setwd("C:/Users/NW/Documents/Master_BI_y_Data_Analisis/Gestion_de_base_de_datos")

getwd()

install.packages("readr")

library(readr)

datos <- read_csv2("data_clean_01.csv")

View(datos)

unique(datos$OriginalCrimeTypeName)

datos %>%
  count(OriginalCrimeTypeName, sort = TRUE) %>%
  print(n = 575)

valores_unicos <- sort(unique(datos$OriginalCrimeTypeName))

View(valores_unicos)

datos_clean <- datos

identical(datos, datos_clean)

crime_dictionary <- c(
  
  # Penal Code
  "^211$" = "Robbery",
  "^240$" = "Assault",
  "^242$" = "Battery",
  "^245$" = "Assault with deadly weapon",
  "^459$" = "Burglary",
  "^470$" = "Forgery",
  "^487$" = "Grand theft",
  "^488$" = "Petty theft",
  "^594$" = "Vandalism",
  "^647b$" = "Prostitution",
  
  # Mental health / welfare
  "^5150$" = "Mental health detention",
  
  # Weapons
  "^417$" = "Brandishing weapon",
  
  # Suspicious / police codes
  "^901$" = "Investigation",
  "^909$" = "Alarm call",
  "^910$" = "Suspicious activity",
  "^911$" = "Emergency call",
  "^913$" = "Suspicious person",
  "^915$" = "Encampment",
  "^916$" = "Disturbance",
  "^917$" = "Suspicious vehicle",
  "^919$" = "Prowler",
  
  # Municipal / parking violations
  "^22500.*" = "Illegal parking",
  "^22514.*" = "Illegal parking commercial zone",
  
  # Municipal code section 7.2.x
  "^7\\.2\\..*" = "Municipal code violation",
  
  # Theft / possession
  "^800.*" = "Theft investigation",
  "^801.*" = "Threat investigation",
  "^852.*" = "Suspicious investigation",
  
  # Drug related
  "^420$" = "Drug related offense",
  
  # Possession codes
  "^518$" = "Extortion related",
  "^519$" = "Extortion threat",
  
  # Other numeric only
  "^[0-9]+$" = "Police code incident"
)

datos_clean$OriginalCrimeTypeName <- str_replace_all(
  datos_clean$OriginalCrimeTypeName,
  crime_dictionary
)

sort(unique(datos_clean$OriginalCrimeTypeName))

length(unique(datos_clean$OriginalCrimeTypeName))

unique(datos_clean$OriginalCrimeTypeName[
  str_detect(datos_clean$OriginalCrimeTypeName, "[0-9]")
])

datos_clean <- datos_clean %>%
  mutate(
    OriginalCrimeTypeName = case_when(
      
      # Robbery
      str_detect(OriginalCrimeTypeName, regex("\\b211\\b", ignore_case = TRUE)) ~ "Robbery",
      
      # Assault / battery
      str_detect(OriginalCrimeTypeName, regex("\\b240\\b", ignore_case = TRUE)) ~ "Assault",
      str_detect(OriginalCrimeTypeName, regex("\\b242\\b", ignore_case = TRUE)) ~ "Battery",
      str_detect(OriginalCrimeTypeName, regex("\\b245\\b", ignore_case = TRUE)) ~ "Assault with deadly weapon",
      
      # Theft / burglary
      str_detect(OriginalCrimeTypeName, regex("\\b459\\b", ignore_case = TRUE)) ~ "Burglary",
      str_detect(OriginalCrimeTypeName, regex("\\b470\\b", ignore_case = TRUE)) ~ "Forgery",
      str_detect(OriginalCrimeTypeName, regex("\\b487\\b", ignore_case = TRUE)) ~ "Grand theft",
      str_detect(OriginalCrimeTypeName, regex("\\b488\\b", ignore_case = TRUE)) ~ "Petty theft",
      
      # Vandalism
      str_detect(OriginalCrimeTypeName, regex("\\b594\\b", ignore_case = TRUE)) ~ "Vandalism",
      
      # Mental health
      str_detect(OriginalCrimeTypeName, regex("\\b5150\\b", ignore_case = TRUE)) ~ "Mental health detention",
      
      # Suspicious activity
      str_detect(OriginalCrimeTypeName, regex("\\b917\\b", ignore_case = TRUE)) ~ "Suspicious vehicle",
      str_detect(OriginalCrimeTypeName, regex("\\b916\\b", ignore_case = TRUE)) ~ "Disturbance",
      str_detect(OriginalCrimeTypeName, regex("\\b915\\b", ignore_case = TRUE)) ~ "Encampment",
      str_detect(OriginalCrimeTypeName, regex("\\b913\\b", ignore_case = TRUE)) ~ "Suspicious person",
      str_detect(OriginalCrimeTypeName, regex("\\b910\\b", ignore_case = TRUE)) ~ "Suspicious activity",
      
      # Emergency
      str_detect(OriginalCrimeTypeName, regex("\\b911\\b", ignore_case = TRUE)) ~ "Emergency call",
      
      # Investigation
      str_detect(OriginalCrimeTypeName, regex("\\b901\\b", ignore_case = TRUE)) ~ "Investigation",
      
      # Municipal code
      str_detect(OriginalCrimeTypeName, regex("7\\.2\\.", ignore_case = TRUE)) ~ "Municipal code violation",
      
      # Parking
      str_detect(OriginalCrimeTypeName, regex("22500", ignore_case = TRUE)) ~ "Illegal parking",
      
      # Drug related
      str_detect(OriginalCrimeTypeName, regex("\\b420\\b", ignore_case = TRUE)) ~ "Drug related offense",
      
      # Default: dejar igual si no coincide
      TRUE ~ OriginalCrimeTypeName
    )
  )

length(unique(datos_clean$OriginalCrimeTypeName))

sort(unique(datos_clean$OriginalCrimeTypeName))

restantes <- unique(
  datos_clean$OriginalCrimeTypeName[
    str_detect(datos_clean$OriginalCrimeTypeName, "[0-9]")
  ]
)

length(restantes)
restantes

crime_dictionary_exact <- c(
  
  # -------- Vehicle Code 500 series (parking / vehicle violations)
  
  "^500e$" = "Illegal parking violation",
  "^500f$" = "Illegal parking violation (specific subsection)",
  "^500h$" = "Illegal parking violation (restricted zone)",
  "^500b$" = "Illegal parking violation (general subsection)",
  "^.25/500e$" = "Illegal parking violation with additional subsection",
  "^500e/rz$" = "Illegal parking violation in restricted zone",
  
  # -------- Penal Code 601 (Trespassing)
  
  "^601$" = "Trespassing",
  "^601 Ug$" = "Trespassing unlawful entry",
  "^601 Rtl$" = "Trespassing retail property",
  "^601rtl$" = "Trespassing retail property",
  "^601uwg$" = "Trespassing unlawful grounds",
  "^601/family$" = "Trespassing family related",
  "^601/415$" = "Trespassing and disturbance",
  "^601/311$" = "Trespassing and public nuisance",
  "^219/601$" = "Trespassing and pedestrian violation",
  
  "^Poss/601$" = "Possible trespassing",
  "^Sleeper 601$" = "Trespassing sleeper encampment",
  "^Aggressive 601$" = "Aggressive trespassing",
  
  # -------- Penal Code possession related
  
  "^221 Poss$" = "Possession related to illegal activity",
  "^221/222 Poss$" = "Possession related to illegal activity multiple sections",
  "^Poss 152$" = "Possible possession violation",
  "^152 Poss$" = "Possession violation",
  "^Poss 207$" = "Possible kidnapping violation",
  "^Poss 519$" = "Possible extortion threat",
  "^519 Poss$" = "Possession related to extortion threat",
  "^528 Poss$" = "Possession of false identification",
  "^Poss 800$" = "Possible theft investigation",
  "^Poss 801$" = "Possible threat investigation",
  
  "^Poss/851 Attemp Poss$" = "Possible attempted theft or obstruction",
  
  # -------- Prostitution
  
  "^647b Poss$" = "Possible prostitution offense",
  
  # -------- Parking and vehicle impound
  
  "^22502a$" = "Improper parking violation",
  "^22507.8a$" = "Parking violation restricted area",
  "^22654e$" = "Vehicle impound violation",
  
  # -------- Municipal code
  
  "^311 X$" = "Municipal code violation",
  "^311x/poss800$" = "Municipal code violation with possible theft",
  
  # -------- Mental health / welfare
  
  "^Poss 5150$" = "Possible mental health detention",
  
  # -------- Alarm / dispatch
  
  "^\\*909\\*$" = "Alarm call",
  "^909x$" = "Alarm call follow up",
  "^Music/909$" = "Alarm call related to disturbance",
  
  # -------- Suspicious / investigation
  
  "^Casing/852$" = "Suspicious casing activity",
  "^Poss/910prem Check$" = "Possible suspicious activity premise check",
  
  # -------- Vehicle / municipal
  
  "^Chp 1030 Veh$" = "Stolen vehicle report",
  
  # -------- Vehicle code robbery / theft specific
  
  "^Vc21113a$" = "Transit robbery",
  
  # -------- CHP / municipal
  
  "^905/muni$" = "Municipal transit violation",
  "^518/muni$" = "Extortion related municipal violation",
  
  # -------- Drug / narcotics
  
  "^418rm$" = "Drug related violation",
  
  # -------- Threat / extortion
  
  "^518hr$" = "Extortion related harassment",
  
  # -------- Misc
  
  "^Adv To 0123$" = "Advised call dispatch",
  "^415 Music$" = "Disturbance music violation",
  
  # -------- Possession general
  
  "^811 Poss$" = "Possession investigation",
  
  # -------- Investigation
  
  "^920 Rtl$" = "Investigation retail property",
  
  # -------- Family related
  
  "^2 Reps$" = "Multiple reporting parties",
  
  # -------- Misc numeric
  
  "^100v$" = "Vehicle violation",
  
  # -------- Misc possession
  
  "^368ca Poss$" = "Possible elder abuse possession",
  
  # -------- Dirtbike
  
  "^Dirtbikes/586$" = "Illegal vehicle operation",
  
  # -------- Misc parking
  
  "^225800e$" = "Illegal parking violation",
  
  # -------- Misc numeric
  
  "^252500e$" = "Illegal parking violation",
  
  # -------- Misc assault
  
  "^222 Att$" = "Attempted assault",
  
  # -------- Misc unknown numeric
  
  "^.52$" = "Municipal violation",
  
  # -------- Misc suspicious
  
  "^Poss Unreported 1030$" = "Possible stolen vehicle",
  
  # -------- Misc trespassing related
  
  "^Rtl/811$" = "Retail investigation",
  
  # -------- Misc municipal
  
  "^502a$" = "Municipal code violation",
  
  # -------- Misc alarm
  
  "^915s$" = "Encampment report",
  
  # -------- Misc alarm
  
  "^Uc Hastings/405$" = "University or municipal violation"
  
)

for(pattern in names(crime_dictionary_exact)) {
  
  datos_clean$OriginalCrimeTypeName <- str_replace_all(
    datos_clean$OriginalCrimeTypeName,
    regex(pattern, ignore_case = TRUE),
    crime_dictionary_exact[[pattern]]
  )
  
}

datos_clean %>%
  count(OriginalCrimeTypeName, sort = TRUE)

str_detect(datos_clean$OriginalCrimeTypeName, "[0-9]")

sort(unique(datos_clean$OriginalCrimeTypeName))

abreviaciones_detectadas <- datos_clean$OriginalCrimeTypeName %>%
  str_extract_all("\\b[A-Za-z]{1,4}\\b") %>%
  unlist() %>%
  unique() %>%
  sort()

datos_clean %>%
  filter(str_detect(OriginalCrimeTypeName, "\\bRtl\\b")) %>%
  distinct(OriginalCrimeTypeName)

corrections <- c(
  
  # Abbreviations
  "\\bPoss\\b" = "Possible",
  "\\bVeh\\b" = "Vehicle",
  "\\bSusp\\b" = "Suspicious",
  "\\bSubj\\b" = "Subject",
  "\\bRp\\b" = "Reporting party",
  "\\bRtl\\b" = "Retail",
  "\\bMun\\b" = "Municipal",
  "\\bPrem\\b" = "Premises",
  "\\bAtt\\b" = "Attempted",
  
  # Misspellings
  "Agressive" = "Aggressive",
  "Cassing" = "Casing",
  "Encampent" = "Encampment",
  "Stattic" = "Static",
  "Wreckless" = "Reckless",
  "Roomate" = "Roommate",
  "Suatters" = "Squatters",
  
  # Case normalization
  "Grand Theft" = "Grand theft",
  "Petty Theft" = "Petty theft"
  
)

for(pattern in names(corrections)) {
  
  datos_clean$OriginalCrimeTypeName <- str_replace_all(
    datos_clean$OriginalCrimeTypeName,
    regex(pattern, ignore_case = FALSE),
    corrections[[pattern]]
  )
  
}

datos_clean$OriginalCrimeTypeName <- str_squish(datos_clean$OriginalCrimeTypeName)

sort(unique(datos_clean$OriginalCrimeTypeName))

any(grepl("[0-9]", datos_clean$OriginalCrimeTypeName))

sort(unique(datos_clean$OriginalCrimeTypeName[
  grepl("[0-9]", datos_clean$OriginalCrimeTypeName)
]))

datos_clean$OriginalCrimeTypeName <- gsub("^152 Jo$", 
                                          "Trespassing – juvenile offender", 
                                          datos_clean$OriginalCrimeTypeName)

datos_clean$OriginalCrimeTypeName <- gsub("^212 Possible$", 
                                          "Possible theft", 
                                          datos_clean$OriginalCrimeTypeName)

datos_clean$OriginalCrimeTypeName <- gsub("^586/poss 588$", 
                                          "Possible bicycle violation or theft", 
                                          datos_clean$OriginalCrimeTypeName)

datos_clean$OriginalCrimeTypeName <- gsub("^811 Male$", 
                                          "Suspicious person – male", 
                                          datos_clean$OriginalCrimeTypeName)

sort(unique(datos_clean$OriginalCrimeTypeName[
  grepl("[0-9]", datos_clean$OriginalCrimeTypeName)
]))
# Extraer todos los caracteres que NO sean letras ni espacio
simbolos <- str_extract_all(
  datos_clean$OriginalCrimeTypeName,
  "[^A-Za-z ]"
)

# Convertir en vector simple
simbolos_unicos <- sort(unique(unlist(simbolos)))

simbolos_unicos

datos_clean <- datos_clean %>%
  mutate(
    OriginalCrimeTypeName = OriginalCrimeTypeName %>%
      
      # quitar espacios extras al inicio/final y normalizar múltiples espacios
      str_squish() %>%
      
      # quitar caracteres de ruido
      str_replace_all("[*'`]", "") %>%
      
      # reemplazar & por "and"
      str_replace_all("&", " and ") %>%
      
      # quitar paréntesis pero mantener contenido
      str_replace_all("[()]", " ") %>%
      
      # convertir guiones o rayas a espacio
      str_replace_all("[-–]", " ") %>%
      
      # limpiar nuevamente espacios extra
      str_squish()
  )


slash_dictionary_lower <- setNames(
  slash_dictionary,   # valores
  names(slash_dictionary)  # patrones
)

print(slash_cases, n = Inf)

slash_dictionary <- c(
  
  "Agg Assault / Adw" = "Aggravated Assault with Deadly Weapon",
  
  "Agg Assault / Adw Dv" = "Aggravated Assault with Deadly Weapon - Domestic Violence",
  
  "Assault / Battery" = "Assault and Battery",
  
  "Assault / Battery Dv" = "Assault and Battery - Domestic Violence",
  
  "Auto Boost / Strip" = "Vehicle Theft or Vehicle Stripping",
  
  "Brewing/pay Dispute" = "Brewing Incident or Payment Dispute",
  
  "Busn/voip" = "Business VoIP Complaint",
  
  "Campers W/bikes" = "Encampment with Bicycles",
  
  "Death / Coroner" = "Death Investigation - Coroner Case",
  
  "Demo / Protest" = "Demonstration or Protest",
  
  "Drops//busn" = "Dropped Call - Business Related",
  
  "Drugs/dealing" = "Drug Dealing",
  
  "Dw/rz" = "Driveway Violation in Restricted Zone",
  
  "H/r" = "Hit and Run",
  
  "I/p" = "Inside Premises",
  
  "In Svc/ On Foot" = "Officer In Service On Foot",
  
  "J/o" = "Juvenile Offense",
  
  "Jo/bolo" = "Juvenile Offense - BOLO Alert",
  
  "Ll/ Tenant" = "Landlord Tenant Dispute",
  
  "Ll/ll" = "Landlord Dispute",
  
  "Ll/td" = "Landlord Tenant Dispute",
  
  "Male/poss Hazard" = "Male Subject - Possible Hazard",
  
  "Meet W/citizen" = "Meet with Citizen",
  
  "Meet W/officer" = "Meet with Officer",
  
  "Panhandler W/pitbull" = "Panhandler with Dog",
  
  "Person W/gun" = "Person with Gun",
  
  "Person W/knife" = "Person with Knife",
  
  "Person W/knife Dv" = "Person with Knife - Domestic Violence",
  
  "Prostitute/solicite" = "Prostitution Solicitation",
  
  "Psych Eval / Hold" = "Psychiatric Evaluation Hold",
  
  "R/o Violation" = "Restraining Order Violation",
  
  "Retail/aggressive" = "Aggressive Behavior at Retail Property",
  
  "Rz/dw" = "Restricted Zone Driveway Violation",
  
  "Threats / Harassment" = "Threats or Harassment",
  
  "Vehicle W/open Door" = "Vehicle with Open Door",
  
  "W/a Hammer" = "Person with Hammer",
  
  "Wanted Vehicle / Sub" = "Wanted Vehicle or Subject",
  
  "Wireless H/u" = "Wireless Hang Up Call"
  
)

datos_clean$OriginalCrimeTypeName <- str_replace_all(
  datos_clean$OriginalCrimeTypeName,
  slash_dictionary_lower
)

slash_cases <- datos_clean %>%
  filter(str_detect(OriginalCrimeTypeName, "/")) %>%
  distinct(OriginalCrimeTypeName) %>%
  arrange(OriginalCrimeTypeName)

print(slash_cases, n = Inf) 

unique(datos_clean$OriginalCrimeTypeName)

# Extraer todas las palabras de 1 a 4 letras
abreviaciones_detectadas <- datos_clean$OriginalCrimeTypeName %>%
  str_extract_all("\\b[A-Za-z]{1,4}\\b") %>%  # \b = palabra completa, {1,4} = 1 a 4 letras
  unlist() %>%
  unique() %>%
  sort()

# Ver todas las abreviaciones detectadas
abreviaciones_detectadas

datos_clean %>%
  filter(str_detect(OriginalCrimeTypeName, "\\b(Npa|Ucpd|Adv|Ug|Co)\\b")) %>%
  select(OriginalCrimeTypeName) %>%
  distinct()

abreviaciones_dic <- c(
  "Adv" = "Advised",
  "Aggr" = "Aggravated",
  "Busn" = "Business",
  "Chp" = "Police",
  "Dw" = "Driveway",
  "IP" = "Inside Premises",
  "Jjo" = "Juvenile Offense",
  "R" = "Reporting Party",
  "St" = "Street",
  "Tz" = "Time Zone",
  "Unkn" = "Unknown",
  "Ug" = "Unlawful Grounds",
  "Nabo" = "Neighbor",
  "A" = "Arrest",
  "Ams" = "Armed Suspect",
  "Atc" = "Attempted Crime",
  "Awol" = "Absent Without Leave",
  "Bat" = "Battery",
  "Bl" = "Block",
  "Bldg" = "Building",
  "Dp" = "Dispatch",
  "Drp" = "Dropped",
  "Fp" = "False Alarm",
  "Gz" = "Gang Zone",
  "H" = "Hit",
  "Hu" = "Human",
  "Ifo" = "Information",
  "Ld" = "Load",
  "Lp" = "Lost Property",
  "Mal" = "Male Subject",
  "Mc" = "Motorcycle",
  "Mcs" = "Motorcycles",
  "No" = "Number",
  "o" = "Officer",
  "Opp" = "Opposition",
  "r" = "Reporting Party",
  "S" = "Subject",
  "Sw" = "Sidewalk",
  "Tro" = "Trooper",
  "Tx" = "Transport",
  "X" = "Unknown Crime"
)

# Construir un patrón seguro con \\b
abreviaciones_dic_safe <- setNames(
  abreviaciones_dic,
  paste0("\\b", names(abreviaciones_dic), "\\b")
)

datos_clean <- datos_clean %>%
  mutate(
    OriginalCrimeTypeName = str_replace_all(
      OriginalCrimeTypeName,
      abreviaciones_dic_safe
    )
  )

# 4️⃣ Detectar abreviaciones residuales (1 a 4 letras)
abreviaciones_residuales <- datos_clean$OriginalCrimeTypeName %>%
  str_extract_all("\\b[A-Za-z]{1,4}\\b") %>%
  unlist() %>%
  unique() %>%
  sort()

# Mostrar las posibles abreviaciones restantes
print(abreviaciones_residuales)

abreviaciones_residuales_dic <- c(
  "Npa" = "Neighborhood Patrol Area",
  "Ucpd" = "University Police Department",
  "Rz" = "Restricted Zone",
  "Uwg" = "Unlawful Grounds",
  "Ip" = "Inside Premises",
  "Jo" = "Juvenile Offense",
  "Lltd" = "Landlord Tenant Dispute",
  "Lltn" = "Landlord Tenant Notice",
  "Cw" = "Curfew Violation",
  "Cz" = "Crime Zone",
  "Dis" = "Dispute",
  "Disp" = "Dispatch",
  "Bart" = "Bartender",
  "Co" = "Company",
  "Dv" = "Domestic Violence",
  "Npat" = "Neighborhood Patrol Area - Team",
  "BOLO" = "Be On Lookout",
  "Muni" = "Municipal",
  "Rept" = "Report",
  "Haz" = "Hazard",
  "Iph" = "Incident Phone",
  "Ped" = "Pedestrian",
  "Phys" = "Physical",
  "Pos" = "Possible",
  "VoIP" = "Voice over IP",
  "Wz" = "Watch Zone"
)

# Crear patrón seguro con \\b para reemplazar solo siglas completas
abreviaciones_residuales_dic_safe <- setNames(
  abreviaciones_residuales_dic,
  paste0("\\b", names(abreviaciones_residuales_dic), "\\b")
)

# Aplicar todos los reemplazos directamente sobre OriginalCrimeTypeName
datos_clean <- datos_clean %>%
  mutate(
    OriginalCrimeTypeName = str_replace_all(
      OriginalCrimeTypeName,
      abreviaciones_residuales_dic_safe
    )
  )
abreviaciones_residuales_dic <- c(
  "Adv"  = "Advised",
  "Aggr" = "Aggravated",
  "Busn" = "Business",
  "Chp"  = "Police",
  "Dw"   = "Driveway",
  "IP"   = "Inside Premises",
  "Jjo"  = "Juvenile Offense",
  "R"    = "Reporting Party",
  "St"   = "Street",
  "Tz"   = "Time Zone",
  "Unkn" = "Unknown",
  "Ug"   = "Unlawful Grounds",
  "Nabo" = "Neighbor",
  "Curb" = "Curb",
  "Juve" = "Juvenile",
  "Juvs" = "Juveniles",
  "Resd" = "Resident",
  "Ret"  = "Return",
  "Ro"   = "Reporting Officer",
  "Rpt"  = "Report",
  "Thru" = "Through",
  "Traf" = "Traffic",
  "Viol" = "Violation"
)
# Verificar si aún quedan abreviaciones de 1 a 4 letras
residuales_final <- datos_clean$OriginalCrimeTypeName %>%
  str_extract_all("\\b[A-Za-z]{1,4}\\b") %>%
  unlist() %>%
  unique() %>%
  sort()

print(residuales_final)

abreviaciones_nuevas_dic <- c(
  "Curb" = "Curb",
  "Juve" = "Juvenile",
  "Juvs" = "Juveniles",
  "Resd" = "Resident",
  "Ret"  = "Return",
  "Ro"   = "Reporting Officer",
  "Rpt"  = "Report",
  "Thru" = "Through",
  "Traf" = "Traffic",
  "Viol" = "Violation"
)

# Aplicar solo estas nuevas abreviaciones sobre OriginalCrimeTypeName
datos_clean <- datos_clean %>%
  mutate(
    OriginalCrimeTypeName = str_replace_all(
      OriginalCrimeTypeName,
      abreviaciones_nuevas_dic
    )
  )

correcciones_finales_dic <- c(
  "Refd" = "Referred",
  "Rep" = "Report",
  "Areport" = "Airport",
  "Openline" = "Open Line",
  "Paydispute" = "Pay Dispute",
  "Violationence" = "Violence",
  "Possible Attemtted" = "Possible Attempt",
  "Unocc" = "Unoccupied"
)

# Función segura para reemplazar palabra por palabra
reemplazo_seguro <- function(texto, dic) {
  palabras <- str_split(texto, "\\s+")[[1]]  # separar por espacios
  palabras <- sapply(palabras, function(p) {
    if (p %in% names(dic)) {
      dic[[p]]  # reemplazo exacto
    } else {
      p
    }
  })
  paste(palabras, collapse = " ")  # unir de nuevo
}

# Aplicar a toda la columna
datos_clean <- datos_clean %>%
  rowwise() %>%
  mutate(
    OriginalCrimeTypeName = reemplazo_seguro(OriginalCrimeTypeName, correcciones_finales_dic),
    OriginalCrimeTypeName = str_to_title(OriginalCrimeTypeName)
  ) %>%
  ungroup()

datos_clean <- datos_clean %>%
  mutate(
    # Quitar caracteres no alfabéticos pegados a palabras
    OriginalCrimeTypeName = str_replace_all(OriginalCrimeTypeName, "[^A-Za-z ]", " "),
    # Reducir letras repetidas consecutivas (más de 2) a máximo 2
    OriginalCrimeTypeName = str_replace_all(OriginalCrimeTypeName, "([A-Za-z])\\1{2,}", "\\1\\1"),
    # Quitar espacios extras
    OriginalCrimeTypeName = str_squish(OriginalCrimeTypeName)
  )

correcciones_dic <- c(
  "Refd" = "Referred",
  "Rep" = "Report",
  "Reportort" = "Report",
  "Reportorting" = "Reporting",
  "Areport" = "Airport",
  "Openline" = "Open Line",
  "Paydispute" = "Pay Dispute",
  "Violationence" = "Violence",
  "Violationation" = "Violation",
  "Possible Attemtted" = "Possible Attempt",
  "Unocc" = "Unoccupied",
  "Returnail" = "Retail",
  "Returnurn" = "Return",
  "Surveillence" = "Surveillance",
  "Juvenilenile" = "Juvenile",
  "Reporting Officerad Rage" = "Reporting Officer Road Rage",
  "Reporting Officeradrage" = "Reporting Officer Road Rage",
  "Reporting Officerbbery" = "Reporting Officer Robbery",
  "Reporting Officerommate" = "Reporting Officer Roommate",
  "Reporting Officerof" = "Reporting Officer Of",
  "Reporting Officerof Squatters" = "Reporting Officer Of Squatters",
  "Sudrugs" = "Drugs",
  "Attempted Juvenilenile Offense" = "Attempted Juvenile Offense",
  "Juvenilenile Disturbance" = "Juvenile Disturbance",
  "Juvenilenile Offense" = "Juvenile Offense",
  "Juvenilenile Offense - Be On Lookout Alert" = "Juvenile Offense - Be On Lookout Alert",
  "Hit And Reportorting Party Injury Accident" = "Hit And Reporting Party - Injury / Accident",
  "Hit And Reportorting Party Vehicle Accident" = "Hit And Reporting Party - Vehicle Accident",
  "Hit And Reportorting Party" = "Hit And Reporting Party",
  "Nabor" = "Neighbor",
  "Nabors" = "Neighbors"
)

# Función segura para reemplazar palabra por palabra
reemplazo_seguro <- function(texto, dic) {
  palabras <- str_split(texto, "\\s+")[[1]]  # separar por espacios
  palabras <- map_chr(palabras, ~ if (.x %in% names(dic)) dic[[.x]] else .x)
  paste(palabras, collapse = " ")  # unir de nuevo
}

# Aplicar las correcciones a toda la columna
datos_clean <- datos_clean %>%
  rowwise() %>%
  mutate(
    OriginalCrimeTypeName = reemplazo_seguro(OriginalCrimeTypeName, correcciones_dic),
    OriginalCrimeTypeName = str_to_title(OriginalCrimeTypeName)  # Capitalizar cada palabra
  ) %>%
  ungroup()

correcciones_15 <- c(
  "Reporting Officerbbery" = "Reporting Officer Robbery",
  "Strongarm Reporting Officerbbery" = "Strongarm Reporting Officer Robbery",
  "Reporting Officerof" = "Reporting Officer Of",
  "Reporting Officerommate" = "Reporting Officer Roommate",
  "Reporting Officeradrage" = "Reporting Officer Road Rage",
  "Sagressive" = "Aggressive",
  "Attemp" = "Attempt",
  "Drugdealer" = "Drug Dealer",
  "Unoccupiedupied" = "Unoccupied",
  "Trafficfic Stop" = "Traffic Stop",
  "Caser" = "Case",
  "Nabor" = "Neighbor",
  "Sleepers" = "Sleeper",
  "Reportorting Officer Violation" = "Reporting Officer Violation",
  "Attempt Reportort" = "Attempt Report"
)

# Función para reemplazo exacto de palabras o frases
reemplazo_exacto <- function(texto, dic) {
  str_replace_all(texto, setNames(dic, names(dic)))
}

# Aplicar las correcciones
datos_clean <- datos_clean %>%
  mutate(
    OriginalCrimeTypeName = reemplazo_exacto(OriginalCrimeTypeName, correcciones_15),
    OriginalCrimeTypeName = str_to_title(OriginalCrimeTypeName)  # opcional: capitalizar
  )

# Vector de correcciones: clave = valor incorrecto, valor = correcto
correcciones_dic <- c(
  "Attemptted" = "Attempted",
  "Attemptt" = "Attempt",
  "Suicide Attemptt" = "Suicide Attempt",
  "Possible Attemptt" = "Possible Attempt",
  "Attemptted Crime" = "Attempted Crime",
  "Possible Attemptted Theft Or Obstruction" = "Possible Attempted Theft Or Obstruction",
  "Reporting Officerad Rage" = "Reporting Officer Road Rage",
  "Dirtbikes" = "Dirt Bikes",
  "Bicylist" = "Bicyclist",
  "Reporting Officer Robbery" = "Reporting Officer Robbery",
  "Strongarm Reporting Officer Robbery" = "Strongarm Reporting Officer Robbery",
  "Hit And Reporting Party Vehicle Accident" = "Hit And Reporting Party Vehicle Accident",
  "Reporting Officer Of" = "Reporting Officer Of",
  "Reporting Officer Of Squatters" = "Reporting Officer Of Squatters",
  "Reporting Officer Roommate" = "Reporting Officer Roommate",
  "Reporting Officer Violation" = "Reporting Officer Violation",
  "Reporting Party Officer Violation" = "Reporting Party Officer Violation",
  "Reporting Officeradrage" = "Reporting Officer Road Rage",
  "Reporting Officerommate" = "Reporting Officer Roommate",
  "Reporting Officerof" = "Reporting Officer Of",
  "Reporting Officerof Squatters" = "Reporting Officer Of Squatters",
  "Reporting Officerad Rage" = "Reporting Officer Road Rage"
)

# Función segura para reemplazar valores según el diccionario
reemplazo_seguro <- function(x, dic) {
  sapply(x, function(val) {
    if (val %in% names(dic)) dic[[val]] else val
  }, USE.NAMES = FALSE)
}

datos_clean <- datos_clean %>%
  mutate(
    OriginalCrimeTypeName = reemplazo_seguro(OriginalCrimeTypeName, correcciones_dic),
    OriginalCrimeTypeName = str_to_title(OriginalCrimeTypeName)  # opcional: capitalizar
  )

datos_clean <- datos_clean %>%
  mutate(
    CrimeCategory = case_when(
      # Violencia y agresiones
      str_detect(OriginalCrimeTypeName, regex("Assault|Aggravated", ignore_case = TRUE)) ~ "Assault",
      str_detect(OriginalCrimeTypeName, regex("Battery|Hit|Fight|Stabbing|Brandishing|Hammer", ignore_case = TRUE)) ~ "Battery / Violence",
      str_detect(OriginalCrimeTypeName, regex("Robbery|Strongarm|Theft|Stolen|Possession|Drug|Drugs|Drugdealer|Drug related", ignore_case = TRUE)) ~ "Property / Theft / Drugs",
      str_detect(OriginalCrimeTypeName, regex("Burglary|Breaking In|Casing|Protestors|Trespassing", ignore_case = TRUE)) ~ "Property / Trespassing",
      
      # Vehículos y tráfico
      str_detect(OriginalCrimeTypeName, regex("Traffic|Parking|Driveway|Vehicle|Tow|Transport|Accident|Road Rage|Roadrage", ignore_case = TRUE)) ~ "Traffic / Vehicle",
      
      # Disturbios públicos, ruido, molestias
      str_detect(OriginalCrimeTypeName, regex("Noise|Disturbance|Trespasser|Loitering|Party|Music|Loud|Boombox|Barking|Dogs|Dog", ignore_case = TRUE)) ~ "Public Disturbance",
      
      # Policía, arrestos, juveniles
      str_detect(OriginalCrimeTypeName, regex("Missing|Juvenile|Prisoner|Arrest|Police|Officer|Ucpd|University Police|Reporting Party", ignore_case = TRUE)) ~ "Law Enforcement / Safety",
      
      # Emergencias y peligros
      str_detect(OriginalCrimeTypeName, regex("Fire|Explosion|Bomb|Hazard|Tazer|Explosive", ignore_case = TRUE)) ~ "Hazard / Emergency",
      
      # Salud mental y bienestar
      str_detect(OriginalCrimeTypeName, regex("Mental|Psychiatric|Intoxicated|Disturbed|Suicide", ignore_case = TRUE)) ~ "Mental Health / Welfare",
      
      # Sexual y prostitución
      str_detect(OriginalCrimeTypeName, regex("Prostitution|Solicitation|Sexual", ignore_case = TRUE)) ~ "Sexual / Prostitution",
      
      # Negocios y administrativos
      str_detect(OriginalCrimeTypeName, regex("Business|Municipal|Inspection|Complaint|VoIP|Pay Dispute|Retail|Vendor", ignore_case = TRUE)) ~ "Administrative / Complaints",
      
      # Animales / mascotas
      str_detect(OriginalCrimeTypeName, regex("Dog|Dogs|Panhandler|Bark|Pups", ignore_case = TRUE)) ~ "Animals / Nuisance",
      
      # Eventos públicos, protestas, reuniones
      str_detect(OriginalCrimeTypeName, regex("Demonstration|Protest|Meet with Citizen|Meet with Officer|Campers|Encampment", ignore_case = TRUE)) ~ "Public Event / Encampment",
      
      # Nuevos casos específicos que estaban en Other
      str_detect(OriginalCrimeTypeName, regex("Refd|Rep|Areport", ignore_case = TRUE)) ~ "Administrative / Complaints",
      str_detect(OriginalCrimeTypeName, regex("Openline", ignore_case = TRUE)) ~ "Administrative / Complaints",
      str_detect(OriginalCrimeTypeName, regex("Paydispute", ignore_case = TRUE)) ~ "Administrative / Complaints",
      str_detect(OriginalCrimeTypeName, regex("Violationence", ignore_case = TRUE)) ~ "Property / Theft / Drugs",
      str_detect(OriginalCrimeTypeName, regex("Possible Attempted|Possible Attemtted", ignore_case = TRUE)) ~ "Property / Trespassing",
      
      # Todo lo demás
      TRUE ~ "Other"
    )
  ) %>%
  relocate(CrimeCategory, .after = OriginalCrimeTypeName)

# Filtrar los casos que quedaron como "Other"
otros_casos <- datos_clean %>%
  filter(CrimeCategory == "Other") %>%
  select(OriginalCrimeTypeName) %>%
  distinct() %>%
  arrange(OriginalCrimeTypeName)

# Mostrar todos los valores
print(otros_casos, n = Inf)

unique(datos_clean$OriginalCrimeTypeName)

datos_clean <- datos_clean %>%
  select(-CallDateTime, -Range)

datos_clean <- datos_clean %>%
  mutate(
    Disposition = recode(Disposition, "Not recorded" = "NR")
  )

datos_clean <- datos_clean %>%
  mutate(
    City = replace_na(City, "San Francisco")
  )

View(datos_clean)

# Seleccionamos las columnas finales relevantes
datos_json <- datos_clean %>%
  select(
    CrimeType = OriginalCrimeTypeName,
    CrimeCategory,
    OffenseDate,
    CallTime,
    Disposition,
    City,
    State
  )

json_final <- toJSON(datos_json, pretty = TRUE, auto_unbox = TRUE)

write(json_final, "datos_clean.json")

cat(json_final[1:1000])  # muestra las primeras 1000 letras del JSON

