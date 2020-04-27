
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

