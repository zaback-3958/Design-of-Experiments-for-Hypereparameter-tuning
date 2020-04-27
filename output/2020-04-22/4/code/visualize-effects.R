
visualize.effect <- function(
    FILE.Factorial.design = NULL,
    Design.name           = NULL
    ) {

    this.function.name <- "visualize.results.core.funds";
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    cat(paste0("starting: ",this.function.name,"()\n"));
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(dplyr);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    DF.factorial.design     <- read.csv(file = FILE.Factorial.design,stringsAsFactors = FALSE);

    cat("\nstr(DF.factorial.design)\n");
    print( str(DF.factorial.design) );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    
    plot.fractional.interaction.effect(
        DF.input = DF.factorial.design,
        Design.name = Design.name)
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    plot.fractional.main.effect(
        DF.input = DF.factorial.design,
        Design.name = Design.name)
    
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\nexiting: ",this.function.name,"()"));
    cat(paste0("\n",paste(rep("#",50),collapse=""),"\n"));
    # return( DF.output );
    return( NULL );

    }

##################################################
plot.fractional.main.effect <- function(
    DF.input    = NULL,
    Design.name  = NULL,
    FILE.ggplot = "Main-effect-fractional-design-plot.png"
    ) {

    require(FrF2);
    require(DoE.base);
    #require(ggplot2);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    #my.ggplot <- initializePlot();


   Main.effect.plot <- MEPlot(DF.input, abbrev = 5, cex.xax = 1.6, cex.main = 2,main = paste("Main-effect-plot-for-fractional-factorial", Design.name))

  
    ggsave(file = FILE.ggplot, plot = Main.effect.plot, dpi = 300, height = 8, width = 12, units = 'in');

    return( NULL );

    }

##################################################
plot.fractional.interaction.effect <- function(
    DF.input    = NULL,
    Design.name  = NULL,
    FILE.ggplot = "interaction-effect-fractional-design-plot.png"
    ) {

    require(FrF2);
    require(DoE.base);
    #require(ggplot2);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    #my.ggplot <- initializePlot();


     interaction.plot <- IAPlot(DF.input, abbrev = 5, show.alias = TRUE, lwd = 2, cex = 2, cex.xax = 1.2, cex.lab = 1.5,
       main = paste("interaction-effect-plot-for-fractional-factorial", Design.name))




    ggsave(file = FILE.ggplot, plot = interaction.plot, dpi = 300, height = 8, width = 12, units = 'in');

    return( NULL );

    }

##################################################
# Hexagonal.heatmap.jaccard01.vs.jaccard02.core.funds <- function(
#     DF.input                     = NULL,
#     plot.limits.x                = c(-0.1   ,   1.1),
#     plot.limits.y                = c(-0.1   ,   1.1),
#     plot.breaks.x                = seq(-0.1,1.1,0.2),
#     plot.breaks.y                = seq(-0.1,1.1,0.2)
#     ) {
#         my.ggplot <- initializePlot();

#         my.ggplot <- my.ggplot + geom_hex(
#             data    = DF.input,
#             mapping = aes(x = jaccard_score_01, y = jaccard_score_02),
#             bins    = 50 )

#         my.ggplot <- my.ggplot + scale_x_continuous(limits = plot.limits.x, breaks = plot.breaks.x);
#         my.ggplot <- my.ggplot + scale_y_continuous(limits = plot.limits.y, breaks = plot.breaks.y);
#         my.ggplot <- my.ggplot + scale_fill_distiller(palette = "Spectral", breaks = seq(3000,18000,3000));
        
#         #my.ggplot <- my.ggplot  + scale_fill_gradient2(low = "red", mid = "green", high = "blue",space = "Lab",breaks = seq(0,2200,200))
#         #my.ggplot <- my.ggplot  + scale_fill_gradient2(low = "red", mid = "green", high = "blue",space = "Lab");
#         #my.ggplot <- my.ggplot + geom_hex(bins = 40)
#         #my.ggplot <- my.ggplot + scale_fill_distiller(type = "div" , breaks = seq(200,2200,200))
#         # my.ggplot <- my.ggplot + geom_hex() + scale_fill_continuous(low = "lightblue01" , high = "darkblue");

#         ggsave(
#             plot   = my.ggplot, 
#             file   = paste0("core-funds","-Hexagonal-heatmap","-jaccard_score_01-vs-jaccard_score_02.png"),
#             dpi    = 300,
#             height = 8,
#             width  = 10,
#             units  = 'in'
#             );

#   }

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
   

 
 

