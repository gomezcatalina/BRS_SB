library(shiny)
library (ggplot2)
library(plyr)
library(sm)
library(datasets)
library(markdown)
library(shinyBS)
library(shinythemes)
theme_set(theme_bw())
BRS <- read.csv("./data/BRS.csv")

BRS$Hearing_group <- factor(BRS$Hearing_group)
BRS$Species <- factor(BRS$Species) 
BRS$Species_group <- factor(BRS$Species_group) 
BRS$Source <- factor(BRS$Source) 
BRS$PriorBehavior <- factor(BRS$PriorBehavior)
BRS$Behavior2 <- factor(BRS$Behavior2, levels=c("Very high", "High", "Moderate", "Low"))

#####################################################################################################################

shinyServer(function(input, output) {
  
############PANEL 1
  output$text1 <- renderText({ 
    paste("Data compiled from studies of marine mammals in the wild 
        in which a behavioural response and received sound levels were reported. 
        The first plot shows the frequency of data cases in relation to the maximum received sound level reported.
        The vertical lines represent in-water acoustic received sound level thresholds commonly used by the National Oceanic and Atmospheric Administration 
        for behavioural disruption (excluding tactical sonar and explosives; dashed line: impulsive sounds, continuous line: non-impulsive sounds). 
        The box plot presents the same data cases, but presented for each behavioural response severity score. Boxplots include 
        the median, lower and upper quartile, sample minimum and sample maximum.
        Each point in the boxplot represents one data case." 

          )
  })
  
  sub.data <- reactive({
    if(input$Hearing_group=="All") { Hgroup <- unique(BRS$Hearing_group) } else { Hgroup <- input$Hearing_group }
    if(input$Species_group=="All") { Sgroup <- unique(BRS$Species_group) } else { Sgroup <- input$Species_group }
    if(input$Source=="All") { Source <- unique(BRS$Source) } else { Source <- input$Source }
    #if(input$Source_division=="All") { Source_division <- unique(BRS$Source_division) } else { Source_division <- input$Source_division }
    if(input$PriorBehavior=="All") { PriorBehavior <- unique(BRS$PriorBehavior) } else { PriorBehavior <- input$PriorBehavior }
    #if(input$Avoidance=="All") { Avoidance <- unique(BRS$Avoidance) } else { Avoidance <- input$Avoidance }
    if(input$Behavior2=="All") { Behavior2 <- unique(BRS$Behavior2) } else { Behavior2 <- input$Behavior2 }
    if(input$RL_unit=="All") { RL_unit <- unique(BRS$RL_unit) } else { RL_unit <- input$RL_unit }
    
    BRS[which(BRS$Hearing_group %in% Hgroup & 
                BRS$Species_group %in% Sgroup & 
                BRS$Source %in% Source & 
                #BRS$Source_division %in% Source_division & 
                BRS$PriorBehavior %in% PriorBehavior & 
                #BRS$Avoidance %in% Avoidance & 
                BRS$Behavior2 %in% Behavior2 &
                BRS$RL_unit %in% RL_unit),]
    #subset(BRS, BRS$Hearing_group %in% Hgroup && BRS$Species_group %in% Sgroup && BRS$Source %in% Source)  
  })
 # print(input$Source)
## Plot 1
output$plot1 <- renderPlot({
  
  
  
    sub <- sub.data()
    #bins <- seq(min(BRS$RL), max(BRS$RL), length.out = input$bins + 1)
    if(nrow(sub)==0) { 
      
      plot(1:10, 1:10, type="n", axes=FALSE, ylab="", xlab="") 
      text(5,5, "No data", cex=5)
   
      } else {
      ggplot(data=sub, aes(RL)) + 
        geom_histogram(aes(y =..density..), 
                       binwidth=input$bins, 
                       col="white", 
                       fill="black", 
                       alpha = .2) + 
        geom_density(col=1) +
        labs(x="Max Received Sound Levels (dB re 1 µ Pa)", y="Relative Frequency")+
        annotate("segment",  x = 120, xend = 120, y = 0, yend = 0.04,
                 colour = "blue", size = 1) +
        annotate("segment",  x = 160, xend = 160, y = 0, yend = 0.04,
                 colour = "blue", size = 1, lty=5) 
    }
  })
  
## Plot 2
output$plot2 <- renderPlot({
    sub <- sub.data()
    if(nrow(sub)==0) { 
      
      plot(1:10, 1:10, type="n", axes=FALSE, ylab="", xlab="") 
      text(5,5, "No data", cex=5)
      
    } else {
      ggplot(sub, aes(x = Behavior2, y = RL)) +
        geom_boxplot(size = .75) +
        geom_jitter(alpha = .5) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) +
        labs(y="Max Received Sound Levels (dB re 1 µ Pa)", x="Behavioural Severity Score") +
        ggtitle("") +
        theme(plot.title = element_text(face="bold"))
    }
 })


############PANEL 2
output$text2 <- renderText({ 
  paste("Frequency of behavioural severity scores (low, moderate and high) 
        for each response variable")})
  
  ## Table 1 3
  output$table1 <- renderDataTable({
     sub <- sub.data()
     if(nrow(sub)==0) { 
       
       plot(1:10, 1:10, type="n", axes=FALSE, ylab="", xlab="") 
       text(5,5, "No data", cex=5)
       
     } else {
    
      sub      
      
    }
  })
    

output$downloadData <- downloadHandler(
    filename = function() {
      paste('BRS_Gomez et al. ', Sys.Date(), '.csv', sep='')
    },
    content = function(file) {
      write.csv(BRS, file, row.names=FALSE)
    }
  )



## Table 1 3
output$table2 <- renderDataTable({
  sub <- sub.data()
  if(nrow(sub)==0) { 
    
    plot(1:10, 1:10, type="n", axes=FALSE, ylab="", xlab="") 
    text(5,5, "No data", cex=5)
    
  } else {
    
    summary(sub)      
    
  }
})


}) # Final parenthesis - do not remove