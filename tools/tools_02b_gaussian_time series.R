# Stephanie.Clay@dfo-mpo.gc.ca
# 2021-03-18

# Make a grid of plots of the Gaussian bloom fits from PhytoFit. (Used for spring blooms)

rm(list=ls())

library(ggplot2)
library(data.table)
library(oceancolouR)
library(dplyr)
library(patchwork)
library(grid)
library(stringr)

# file containing the bloom metrics/settings and the annual stats for each fit,
# created by tools_01a_format_bloommetrics_for_plotting.R
file <- "verified_fits/occci/labrador_sea_spring/verified_fits_labrador_sea_spring.Rdata"

output_file <- gsub(".Rdata","_gaussians.png",file)

# include fits for these polygons
polys <- c("CLS","GS","LAS") # labrador sea
# polys <- c("CSS_V02","ESS_V02","WSS_V02","LS_V02","GB_V02","HL2","P5") # scotian shelf
# polys <- c("CS_V02","MS_V02","NEGSL_V02","NWGSL_V02") # gulf of saint lawrence
# polys <- c("AC","FP","HB","HIB","NENS","SAB","SES","SPB") # newfoundland
# polys <- c("SABMPA","SABUP","SABDOWN")
# polys <- c("custom")

# include fits for these years
years <- 1997:2024


#*******************************************************************************

stats <- get(load(file)) %>%
  dplyr::filter(Region %in% polys & Year %in% years) %>%
  dplyr::arrange(Region, Year)

plot_list <- list()

for (i in 1:nrow(stats)) {
    st <- stats[i,]
    year <- st$Year
    region <- st$Region
    interval <- st$settings_composite
    dailystat <- st$settings_dailystat
    fitcov <- as.numeric(st$settings_percent)
    logchla <- as.logical(st$settings_log_chla)
    xlim <- as.numeric(strsplit(st$settings_t_range,split=",")[[1]])
    if (sum(grepl("beta", colnames(st)))==0) {st$beta <- 0}
    df <- st$stats[[1]]
    if (nrow(df) <= 1) { # if nrow(df)==1 then the table is blank (no data ever)
      plot_list[[paste0(year,"_",region)]] <- ggplot()
      next
    }
    if (dailystat=="average") {
      if (logchla) {
        df$y <- df$mean_log10
      } else {
        df$y <- df$mean
      }
    } else if (dailystat=="median") {
      if (logchla) {
        df$y <- df$median_log10
      } else {
        df$y <- df$median
      }
    }
    df[df$percent_coverage <= fitcov, "y"] <- NA
    if (all(!is.finite(df$y))) {
      plot_list[[paste0(year,"_",region)]] <- ggplot()
      next
    }
    # plot all real data points that have sufficient percent coverage, sized by percent coverage
    p <- ggplot(df) +
      geom_point(aes(x=doy, y=y, size=percent_coverage), alpha=0.6) +
      theme_bw() +
      ggtitle(region) +
      labs(y=year) +
      scale_size_continuous(name = "Percent coverage",
                            breaks = c(25, 50, 75, 100),
                            limits = c(10, 100),
                            labels = c(25, 50, 75, 100),
                            range = c(0.5, 3)) +
      coord_cartesian(xlim=c(0,365)) +
      theme(axis.title.y=element_text(size=14,angle=90,hjust=0.5,vjust=1),
            axis.title.x=element_blank(),
            plot.title=element_text(size=14,hjust=0.5,vjust=0.5),
            panel.border = element_rect(colour="black", fill=NA, linewidth=0.4))
    # add tstart/tend/tmax and gaussian curve, if available
    if (is.na(st$B0)) {
      p <- p + annotation_custom(grobTree(textGrob("NO FIT", x=0.1, y=0.9,vjust=1,hjust=0, gp=gpar(fontsize=16, col="red"))))
      tstart <- tend <- tmax_fit <- tmax_real <- NA
    } else {
      # plot the fitted line in the range of days used in the fit (i.e. given by tmp_t_range)
      tmax_fit <- try(as.numeric(unlist(st[,"t[max_fit]"])), silent=TRUE)
      if (class(tmax_fit)=="try-error") {tmax_fit <- st$`t.max_fit.`}
      if (all(is.na(df$model))) {
        df$model[dplyr::between(df$doy,xlim[1],xlim[2])] <- shifted_gaussian(tv=xlim[1]:xlim[2],B0=st$B0,beta=st$beta,h=st$h,sigma=st$sigma,tmax=tmax_fit)
      }
      df$model[!dplyr::between(df$doy,xlim[1],xlim[2])] <- NA
      p <- p + geom_line(data=df, aes(x=doy, y=model), color="blue")
    }
    if (st$manual_fit) {
      p <- p + theme(panel.border = element_rect(colour="red", fill=NA, linewidth=1.5))
    }
    plot_list[[paste0(year,"_",region)]] <- p
}

# row names only on outer edge left
r_inds <- 1:length(plot_list) %in% 1:length(years)
plot_list[!r_inds] <- lapply(plot_list[!r_inds], function(x) {x+theme(axis.title.y=element_blank())})

# make a png
ggsave(filename=output_file,
       plot=wrap_plots(plot_list, nrow=length(years), byrow=FALSE) +
           plot_layout(guides="collect") & theme(legend.position="bottom"),
       dpi=100,
       units="px",
       width=(300*length(polys)),
       height=(180*(length(years)+1)),
       limitsize=FALSE)

cat("% manual fits:",(100*(sum(stats$manual_fit)/nrow(stats))),"\n")
cat("Num manual fits:",sum(stats$manual_fit),"/",nrow(stats),"\n")

