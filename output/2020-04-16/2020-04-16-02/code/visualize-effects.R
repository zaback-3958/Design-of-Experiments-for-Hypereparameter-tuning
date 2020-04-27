
visualize.results.core.funds <- function(
    FILE.predicted.cgfs      = NULL,
    FILE.non.unique.cgfs     = NULL,
    FILE.description.to.cgfs = NULL,
    FILE.input.stage01     = NULL
    ) {

    this.function.name <- "visualize.results.core.funds";
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    cat(paste0("starting: ",this.function.name,"()\n"));
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    DF.predicted.cgfs      <- read.csv(file = FILE.predicted.cgfs,      stringsAsFactors = FALSE);
    DF.non.unique.cgfs     <- read.csv(file = FILE.non.unique.cgfs,     stringsAsFactors = FALSE);
    DF.description.to.cgfs <- read.csv(file = FILE.description.to.cgfs, stringsAsFactors = FALSE);
    DF.jaccard.to.plot01    <- FILE.input.stage01 ;

    cat("\nstr(DF.predicted.cgfs)\n");
    print( str(DF.predicted.cgfs)   );

    cat("\nstr(DF.non.unique.cgfs)\n");
    print( str(DF.non.unique.cgfs)   );

    cat("\nstr(DF.description.to.cgfs)\n");
    print( str(DF.description.to.cgfs)   );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    # DF.predicted.cgfs <- as.data.frame(DF.predicted.cgfs);
    # DF.predicted.cgfs[,"unity"] <- 1;
    # DF.predicted.cgfs <- DF.predicted.cgfs     %>%
    #     dplyr::group_by( synthetic_ID )        %>%
    #     dplyr::mutate( index = cumsum(unity) ) %>%
    #     dplyr::select( -unity );
    # DF.predicted.cgfs <- as.data.frame(DF.predicted.cgfs);

    cat("\nstr(DF.predicted.cgfs)\n");
    print( str(DF.predicted.cgfs)   );

    # write.csv(
    #     file      = "core-funds-predicted-cgfscode-index.csv",
    #     x         = DF.predicted.cgfs,
    #     row.names = FALSE
    #     );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    # DF.temp.predicted <- DF.predicted.cgfs %>%
    #     filter( index == 1 );
    # DF.temp.predicted <- as.data.frame(DF.temp.predicted);
    DF.temp.predicted <- DF.predicted.cgfs;

    DF.temp.predicted[,"predicted_cgfs_correct"] <- ( DF.temp.predicted[,"cgfscode"] == DF.temp.predicted[,"cgfscode_train"] );

    write.csv(
        file      = "core-funds-predicted-cgfscode-diagnostics.csv",
        x         = DF.temp.predicted,
        row.names = FALSE
        );

    cat("\nstr(DF.temp.predicted)\n");
    print( str(DF.temp.predicted)   );

    cat('\nsum(DF.temp.predicted[,"predicted_cgfs_correct"])\n');
    print( sum(DF.temp.predicted[,"predicted_cgfs_correct"])   );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    plot.histogram.jaccard.score.core.funds(
        DF.input = DF.temp.predicted
        );
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    
    DF.jaccard.to.plot02 <- DF.temp.predicted %>%
        dplyr::select (synthetic_ID,jaccard_score,stage) %>%
        dplyr::rename(jaccard_score_02 = jaccard_score)

    cat("\nstr(DF.jaccard.to.plot02)\n");
    print( str(DF.jaccard.to.plot02)   );

    DF.jaccard.to.plot <- left_join(
        x  = DF.jaccard.to.plot01,
        y  = DF.jaccard.to.plot02,
        by = "synthetic_ID"
        );

    DF.temp.jaccard.plot <-  DF.jaccard.to.plot
    DF.temp.jaccard.plot[,"stage"] <- as.factor(DF.temp.jaccard.plot[,"stage"])

    cat("\nlevels stage\n");
    print( levels(DF.temp.jaccard.plot[,"stage"])   );


    DF.temp.jaccard.plot <- DF.temp.jaccard.plot %>%
        dplyr::filter( !is.na(stage) )
    DF.temp.jaccard.plot <- as.data.frame(DF.temp.jaccard.plot);


    cat("\nstr(DF.temp.jaccard.plot)\n");
    print( str(DF.temp.jaccard.plot)   );


    write.csv(
        file      = paste0("core-funds-jaccard-to-plot.csv"),
        x         = DF.temp.jaccard.plot,
        row.names = FALSE
        );



    Hexagonal.heatmap.jaccard01.vs.jaccard02.core.funds(
        DF.input = DF.temp.jaccard.plot
        );


    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    # return( DF.output );
    return( NULL );

    }

##################################################
plot.histogram.jaccard.score.core.funds <- function(
    DF.input    = NULL,
    FILE.ggplot = "core-funds-plot-histogram-jaccard-score.png"
    ) {

    require(ggplot2);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    my.ymax <- 25000;
    
    nrow.DF.input <- nrow(DF.input);

    cgfs.correct.count   <- sum(DF.input[,"predicted_cgfs_correct"]);
    cgfs.correct.percent <- round(x = 100 * cgfs.correct.count / nrow.DF.input, digits = 2);

    score.one.count   <- sum(1 == DF.input[,"jaccard_score"]);
    score.one.percent <- round(x = 100 * score.one.count / nrow.DF.input, digits = 2);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    my.ggplot <- initializePlot();

    my.ggplot <- my.ggplot + geom_histogram(
        data     = DF.input,
        mapping  = aes(x = jaccard_score, fill = predicted_cgfs_correct),
        binwidth = 0.05,
        alpha    = 0.50
        );

    my.ggplot <- my.ggplot + scale_x_continuous(limits=c(0,1.1),    breaks=seq(0,1,0.2));
    my.ggplot <- my.ggplot + scale_y_continuous(limits=c(0,my.ymax),breaks=seq(0,my.ymax,5000));
    my.ggplot <- my.ggplot + xlab(label = "Jaccard score");
    my.ggplot <- my.ggplot + ylab(label = "count");

    my.ggplot <- my.ggplot + annotate(
        geom  = "text",
        label = paste0("# records coded = ",nrow.DF.input),
        hjust = 0,
        x     = 0.01,
        y     = 0.95 * my.ymax,
        size  = 8
        );

    my.ggplot <- my.ggplot + annotate(
        geom  = "text",
        label = paste0("# records with score 1 = ",score.one.count," (",score.one.percent,"%)"),
        hjust = 0,
        x     = 0.01,
        y     = 0.90 * my.ymax,
        size  = 8
        );

    my.ggplot <- my.ggplot + annotate(
        geom  = "text",
        label = paste0("# records correctly coded = ",cgfs.correct.count," (",cgfs.correct.percent,"%)"),
        hjust = 0,
        x     = 0.01,
        y     = 0.85 * my.ymax,
        size  = 8
        );


    ggsave(file = FILE.ggplot, plot = my.ggplot, dpi = 300, height = 8, width = 12, units = 'in');

    return( NULL );

    }

##################################################
Hexagonal.heatmap.jaccard01.vs.jaccard02.core.funds <- function(
    DF.input                     = NULL,
    plot.limits.x                = c(-0.1   ,   1.1),
    plot.limits.y                = c(-0.1   ,   1.1),
    plot.breaks.x                = seq(-0.1,1.1,0.2),
    plot.breaks.y                = seq(-0.1,1.1,0.2)
    ) {
        my.ggplot <- initializePlot();

        my.ggplot <- my.ggplot + geom_hex(
            data    = DF.input,
            mapping = aes(x = jaccard_score_01, y = jaccard_score_02),
            bins    = 50 )

        my.ggplot <- my.ggplot + scale_x_continuous(limits = plot.limits.x, breaks = plot.breaks.x);
        my.ggplot <- my.ggplot + scale_y_continuous(limits = plot.limits.y, breaks = plot.breaks.y);
        my.ggplot <- my.ggplot + scale_fill_distiller(palette = "Spectral", breaks = seq(3000,18000,3000));
        
        #my.ggplot <- my.ggplot  + scale_fill_gradient2(low = "red", mid = "green", high = "blue",space = "Lab",breaks = seq(0,2200,200))
        #my.ggplot <- my.ggplot  + scale_fill_gradient2(low = "red", mid = "green", high = "blue",space = "Lab");
        #my.ggplot <- my.ggplot + geom_hex(bins = 40)
        #my.ggplot <- my.ggplot + scale_fill_distiller(type = "div" , breaks = seq(200,2200,200))
        # my.ggplot <- my.ggplot + geom_hex() + scale_fill_continuous(low = "lightblue01" , high = "darkblue");

        ggsave(
            plot   = my.ggplot, 
            file   = paste0("core-funds","-Hexagonal-heatmap","-jaccard_score_01-vs-jaccard_score_02.png"),
            dpi    = 300,
            height = 8,
            width  = 10,
            units  = 'in'
            );

  }

   ##################################################
    # scatterplots.jaccard01.vs.jaccard02.core.funds <- function(
    # DF.input                     = NULL,
    # plot.limits.x                = c(0   ,   1),
    # plot.limits.y                = c(0   ,   1),
    # plot.breaks.x                = seq(0,1,0.2),
    # plot.breaks.y                = seq(0,1,0.2)
    # ) {

    
    #     my.ggplot <- initializePlot();
    #     my.ggplot <- my.ggplot + geom_point(
    #         data    = DF.input,
    #         mapping = aes(x=jaccard_score_01, y = jaccard_score_02, color = stage, shape = stage )
    #         );
       
    #     my.ggplot <- my.ggplot + scale_x_continuous(limits = plot.limits.x, breaks = plot.breaks.x);
    #     my.ggplot <- my.ggplot + scale_y_continuous(limits = plot.limits.y, breaks = plot.breaks.y);
    #     my.ggplot <- my.ggplot + xlab("jaccard_score_01");
    #     my.ggplot <- my.ggplot + ylab("jaccard_score_02");
    #     ggsave(
    #         plot   = my.ggplot, 
    #         file   = paste0("core-funds","Scatterplot-","-jaccard_score_01-vs-jaccard_score_02.png"),
    #         dpi    = 300,
    #         height = 8,
    #         width  = 10,
    #         units  = 'in'
    #         );

    #     }
   

 
 

