#runApp("~/CatalinaSync/BRSAppCopy/") uncomment when reading from MAC - if reading from PC does not need this line of code
library(shiny)
library(shinythemes)

shinyUI(navbarPage("Supplementary material",
                   theme = shinytheme("cerulean"),
                   tabPanel("About", 
                            textInput("Clave1", "C.Gomez, J.W.Lawson, A.J.Wright, A.Buren, D.Tollit, V.Lesage", ""),     
                            conditionalPanel("input.Clave1 == ''",
                                             titlePanel(h2("A systematic review on the behavioural responses of wild marine mammals to noise", align = "center")),
                                             
                                             sidebarLayout(
                                               
                                               sidebarPanel( 
                                                 img(src = "dolphin.png", height = 650, width = 250),
                                                 br(),
                                                 h6("Bottlenose dolphin in the Sea of Cortes  © C. Gomez"),
                                                 h6("Last Updated: October 2016")),
                                               
                                               mainPanel(
                                                 br(),
                                                 h4("Supplementary material 2 (S2)"), 
                                                 h5("Data cases gathered in systematic review on the behavioural responses of wild marine mammals to noise."), 
                                                 h4("Abstract"),
                                                 h5("Noise can cause marine mammals to interrupt their feeding, alter their vocalizations, or leave important habitat, among other behavioural responses. The current North American paradigm for regulating activities that may result in behavioural responses identifies received sound levels (RL), at which individuals are predicted to display significant behavioural responses (often termed harassment). The recurrent conclusion about the need for considering context of exposure, in addition to RL, when assessing probability and severity of behavioural responses led us to conduct a systematic literature review (370 papers) and analysis (79 studies, 195 data cases). The review summarized the critical and complex role of context of exposure. The analysis emphasized that behavioural responses in cetaceans (measured via a linear severity scale) were best explained by the interaction between sound source (continuous, sonar or seismic/explosion) and functional hearing group (a proxy for hearing capabilities). Importantly, more severe behavioural responses were not consistently associated with higher RL, and vice versa. This indicates that monitoring and regulation of acoustic effects from activities on cetacean behaviour should not exclusively rely upon generic multi-species RL thresholds. We recommend replacing the behavioural response severity score with a response/no response dichotomous approach that can represent a measure of impact in terms of habitat loss and degradation."),
                                                 img(src = "marmamm.png", height = 580, width = 780), 
                                                 h6("Upper left: Sowerbys' beaked whale in the Gully Marine Protected Area (MPA), 
                                                    Upper right: Sperm whale in the sea of Cortes,
                                                    Lower left: Blue whale in the Gully MPA,
                                                    Lower right: Grey Seal in Sable Island
                                                    © C. Gomez")
                                                 
                                                 
                                                 )))),
                   
                   tabPanel("Plots", ########################################################################
                            textInput("Clave2", "C. Gomez, J.W. Lawson, A.J.Wright, A.Buren, D.Tollit, V. Lesage", ""),
                            conditionalPanel("input.Clave2 == ''",
                                             titlePanel(h2("Behavioural response severity scores and Received Levels", align = "center")),
                                             sidebarLayout(
                                               sidebarPanel(
                                                 h3("Filters"),
                                                 selectInput("Species_group", 
                                                             label = "Species group",
                                                             choices = c("All", 
                                                                         "Beaked whale",
                                                                         "Beluga",
                                                                         "Black fish",
                                                                         "Dolphin",
                                                                         "Killer whale",
                                                                         "Manatees",
                                                                         "Mysticetes",
                                                                         "Pinnipeds (in water)",
                                                                         "Porpoise",
                                                                         "Sperm whale")),
                                                 
                                                 selectInput("Hearing_group", 
                                                             label = "Hearing frequency group",
                                                             choices = c("All", 
                                                                         "High-frequency", 
                                                                         "Low-frequency",
                                                                         "Mid-frequency")),
                                                 
                                                 selectInput("Source", 
                                                             label = "Sound source type",
                                                             choices = list("All", "Acoustic alarm",
                                                                            "Artificial sounds",
                                                                            "Broadband",
                                                                            "High frequency",
                                                                            "LFAS", 
                                                                            "MFAS", 
                                                                            "Pile driving",
                                                                            "Seismic-Explosion")),
                                                 
                                                 selectInput("PriorBehavior", 
                                                             label = "Behaviour prior to sound exposure",
                                                             choices = list("All", 
                                                                            "Foraging",
                                                                            "Traveling", 
                                                                            "Socializing", 
                                                                            "Resting")),
                                                 
                                                 h3("Response Variable"),
                                                 
                                                 selectInput("Behavior2", 
                                                             label = "Behavioural Severity Score",
                                                             choices = list("All", 
                                                                            "Very high",
                                                                            "High",
                                                                            "Moderate",
                                                                            "Low")),
                                                 sliderInput("bins",
                                                             label ="Bin width",
                                                             min = 1,
                                                             max = 10,
                                                             value = 10),
                                                 
                                                 h3("Received Sound Level SPL"),
                                                 
                                                 selectInput("RL_unit", 
                                                             label = "rms and/or peak",
                                                             choices = list("All", 
                                                                            "peak or peak-to-peak",
                                                                            "rms",
                                                                            "Not explicit"))),
                                               
                                               
                                               # Main panel             
                                               mainPanel(
                                                 #conditionalPanel("input.Password == 'crea_acceso!'",
                                                 textOutput("text1"),
                                                 plotOutput("plot1"),
                                                 plotOutput("plot2"))
                                               
                                             )
                                             
                            )
                            
                   )
                   
                   ,
                   
                   tabPanel("Raw Data", ########################################################################
                            textInput("Clave3", "C. Gomez, J.W. Lawson, A.J.Wright, A.Buren, D.Tollit, V. Lesage", ""),
                            conditionalPanel("input.Clave3 == ''",
                                             titlePanel(h1("A systematic review and meta-analysis on the behavioural responses of wild marine mammals to noise", align = "center")),
                                             # sidebarLayout(
                                             sidebarPanel(h2("Download Data")
                                                          ,
                                                          #                                            radioButtons("filetype", "File type:",
                                                          #                                                         choices = c("csv", "txt")),
                                                          downloadButton('downloadData', 'Download'),
                                                          h5("Note: Raw data includes maximum SPL RL reported and it does not include Pinnipeds exposed to sounds in the air.
                                                             Each data case represents either one study or multiple studies; several data cases can belong to the same study.")
                                                          #, 
                                                          ), 
                                             # Main panel             
                                             mainPanel(
                                               
                                               dataTableOutput("table1")
                                               
                                               # )
                                               
                                             )
                            ))
                   
                   
                   )) # final parenthesis - do not remove
