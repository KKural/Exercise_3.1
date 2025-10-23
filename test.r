# ============================================================
# Criminology Scenarios — Manual Correlation & Regression (EN)
# - "How this app works" first, then scenario/dataset, task & steps
# - Random/seedable data, N 0–50, variables 2–10
# - Modes: Bivariate (X,Y) or Multiple (Y ~ up to 4 X’s; dataset may have up to 10 vars)
# - Students compute manually using your exact 1–15 steps (4 dp checks)
# - Final stats at 2 dp; gentle feedback (neutral→red/green). No answer reveal.
# - Extra variables are scenario-related (names + linear relation to main X/Y)
# - Row table headers match your screenshots; checker uses internal keys.
# ============================================================

suppressPackageStartupMessages({
  library(shiny)
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(rhandsontable)
  library(MASS)
  library(scales)
  library(purrr)
})

`%||%` <- function(a, b) if (is.null(a)) b else a

# ---------- helpers ----------
check_decimals <- function(user_val, true_val, target_decimals = 4, tol = NULL) {
  if (is.null(tol)) tol <- 0.5 * 10^(-target_decimals)  # allow correct rounding
  if (is.na(user_val) || is.na(true_val)) return(NA)    # NA => neutral (no red yet)
  abs(round(user_val, target_decimals) - round(true_val, target_decimals)) <= tol
}
check_col_vec <- function(user_vec, true_vec, target_decimals = 4, tol = NULL) {
  mapply(function(u, t) check_decimals(u, t, target_decimals, tol), user_vec, true_vec)
}
safe_id <- function(x) gsub("[^A-Za-z0-9_]", "_", x)

# subscript digits for labels X₁, X₂, …
sub_num <- function(i){
  subs <- c("0"="₀","1"="₁","2"="₂","3"="₃","4"="₄","5"="₅","6"="₆","7"="₇","8"="₈","9"="₉")
  paste0(sapply(strsplit(as.character(i), "")[[1]], function(d) subs[[d]]), collapse = "")
}
Xk <- function(k) paste0("X", sub_num(k))  # "X₁" etc

# safe seed
safe_seed <- function(seed_in) {
  if (is.null(seed_in)) return(NULL)
  s <- suppressWarnings(as.numeric(seed_in))
  if (is.na(s)) return(NULL)
  s <- as.integer(abs(floor(s)) %% .Machine$integer.max)
  if (is.na(s)) return(NULL)
  s
}

# ---------- concept primers ----------
concepts_for <- function(sc_id) {
  switch(sc_id,
         "crime_program" = c(
           "<b>Burglary rate:</b> burglaries per 1,000 residents.",
           "<b>Program exposure:</b> % of households reached by prevention."
         ),
         "hotspots_policing" = c(
           "<b>Hot spots policing:</b> focus patrol at small high-crime places.",
           "<b>Calls for service (CFS):</b> requests for police help."
         ),
         "fear_disorder" = c(
           "<b>Fear of crime:</b> worry about being victimized.",
           "<b>Disorder:</b> cues like litter, graffiti, rowdy behaviour."
         ),
         "police_public_relations" = c(
           "<b>Procedural justice:</b> respectful, fair treatment and voice.",
           "<b>Trust in police:</b> belief police act effectively and fairly."
         ),
         "guardianship_victimization" = c(
           "<b>Guardianship:</b> people/tools protecting places (locks, lights).",
           "<b>Victimization:</b> # of times a household was victim."
         ),
         "biosocial" = c(
           "<b>Impulsivity:</b> acting quickly without planning.",
           "<b>Aggressive incidents:</b> fights or threats recorded by school."
         ),
         "reentry_recidivism" = c(
           "<b>Support hours:</b> help with jobs, housing, documents.",
           "<b>Recidivism risk:</b> 0–100 chance of reoffending."
         ),
         "cyber_training" = c(
           "<b>Phishing training:</b> practice spotting fake emails.",
           "<b>Click-through rate (CTR):</b> % of simulated phishing links clicked."
         ),
         character(0)
  )
}

# ---------- scenarios ----------
scenarios <- list(
  list(
    id = "crime_program",
    title = "Crime prevention program rollout",
    vignette = "A city rolled out a prevention program across neighborhoods. Explore whether higher exposure relates to lower burglary rates.",
    vars = list(x = list(name="ProgramExposure", unit="%"), y = list(name="BurglaryRate", unit="per 1,000")),
    gen  = list(r_target = -0.45),
    extras = c("PoliceVisibility","CommunityMeetings","RepeatVictimRate","StreetLighting","NeighbourWatch")
  ),
  list(
    id = "hotspots_policing",
    title = "Hot spots policing",
    vignette = "Precincts vary in foot patrol hours at hot spots. Assess association with calls for service (CFS).",
    vars = list(x = list(name="FootPatrolHours", unit="hours/week"), y = list(name="CallsForService", unit="per week")),
    gen  = list(r_target = -0.25),
    extras = c("DirectedPatrols","Arrests","ResponseTime","ProactiveStops","PublicDisorderCalls")
  ),
  list(
    id = "fear_disorder",
    title = "Fear of crime & neighborhood disorder",
    vignette = "Surveyed residents rate physical/social disorder and fear of crime.",
    vars = list(x = list(name="DisorderIndex", unit="0–10"), y = list(name="FearScore", unit="0–100")),
    gen  = list(r_target = 0.55),
    extras = c("Incivilities","CollectiveEfficacy","StreetLighting","GraffitiReports","LitterComplaints")
  ),
  list(
    id = "police_public_relations",
    title = "Police–public relations",
    vignette = "Procedural justice perceptions vs trust in police across districts.",
    vars = list(x = list(name="ProceduralJustice", unit="1–7"), y = list(name="TrustInPolice", unit="1–7")),
    gen  = list(r_target = 0.70),
    extras = c("Fairness","Respect","Voice","Satisfaction","ComplaintRate")
  ),
  list(
    id = "guardianship_victimization",
    title = "Guardianship & victimization",
    vignette = "Households' guardianship scores vs victimization incidents.",
    vars = list(x = list(name="Guardianship", unit="0–10"), y = list(name="Victimization", unit="count")),
    gen  = list(r_target = -0.40),
    extras = c("LockQuality","OutdoorLighting","AlarmOwnership","RoutineActivities","CapableGuardian")
  ),
  list(
    id = "biosocial",
    title = "Biosocial risk",
    vignette = "Impulsivity vs aggressive incidents among youths.",
    vars = list(x = list(name="Impulsivity", unit="z-score"), y = list(name="AggressiveIncidents", unit="school reports/term")),
    gen  = list(r_target = 0.45),
    extras = c("SelfControl","PeerDeviance","TeacherSupport","ParentalMonitoring","SchoolConnectedness")
  ),
  list(
    id = "reentry_recidivism",
    title = "Reentry support & recidivism risk",
    vignette = "Post-release support service hours vs a validated recidivism risk score.",
    vars = list(x = list(name="SupportHours", unit="per month"), y = list(name="RecidivismRisk", unit="0–100")),
    gen  = list(r_target = -0.35),
    extras = c("HousingSupport","EmploymentWorkshops","IDAssistance","CaseContacts","SubstanceCounseling")
  ),
  list(
    id = "cyber_training",
    title = "Cybercrime exposure training",
    vignette = "Phishing training hours vs simulated click-through rate (CTR).",
    vars = list(x = list(name="TrainingHours", unit="hours"), y = list(name="ClickThroughRate", unit="%")),
    gen  = list(r_target = -0.55),
    extras = c("QuizScores","SimulatedReports","AwarenessIndex","TimeToReport","PolicyKnowledge")
  )
)

scenario_choices <- setNames(
  vapply(scenarios, `[[`, character(1), "id"),
  vapply(scenarios, `[[`, character(1), "title")
)

get_sc <- function(id){ for (s in scenarios) if (s$id == id) return(s); NULL }

rnd_name_list <- function(k){
  pool <- c("Hours","Practice","Speed","Height","Weight","Age","Study","Score","Income",
            "Distance","Time","Risk","Trust","Engagement","Satisfaction","Effort","Error",
            "Clicks","Latency","Quality","BurglaryRate","CallsForService","FearScore","DisorderIndex",
            "ProceduralJustice","PoliceTrust","Guardianship","Victimization","Impulsivity","Aggression",
            "SupportHours","RecidivismRisk","TrainingHours","CTR")
  sample(pool, k, replace = FALSE)
}

# -------- data generation --------
make_random_multi <- function(n = 15, seed = NULL, k = 2, names = NULL){
  ss <- safe_seed(seed); if (!is.null(ss)) set.seed(ss)
  k <- max(2, min(10, k))
  if (n <= 0) {
    df <- tibble::tibble(Entity = character()); for (j in 1:k) df[[paste0("Var", j)]] <- numeric(); return(df)
  }
  Z <- matrix(rnorm(n * k), n, k)
  M <- (matrix(rnorm(k*k), k, k) + t(matrix(rnorm(k*k), k, k)))/2
  X <- scale(Z %*% M)[, 1:k, drop=FALSE]
  centers <- seq(20, 70, length.out = k)
  scales  <- seq(6, 14, length.out = k)
  for (j in 1:k) X[,j] <- round(centers[j] + scales[j]*X[,j], 2)
  vnames <- names %||% rnd_name_list(k)
  df <- as.data.frame(X); names(df) <- vnames
  tibble::tibble(Entity = paste0("Unit ", seq_len(n))) |> dplyr::bind_cols(tibble::as_tibble(df))
}

# scenario-driven 2 vars (+ extras related to scenario)
make_scenario_data <- function(sc, n = 20, seed = NULL, k_total = 2){
  ss <- safe_seed(seed); if (!is.null(ss)) set.seed(ss)
  xname <- sc$vars$x$name; yname <- sc$vars$y$name
  # latent standardized
  Xz <- rnorm(n); eps <- rnorm(n)
  r <- sc$gen$r_target %||% 0
  Yz <- r*Xz + sqrt(max(0, 1 - r^2))*eps
  # scale to friendly units
  scale_by_unit <- function(z, center, scale) round(center + scale*as.numeric(scale(z)), 2)
  x_center <- switch(sc$vars$x$unit, "%"=50, "0–10"=5, "1–7"=4, "hours"=20, "per month"=15, "z-score"=0, 30)
  x_scale  <- switch(sc$vars$x$unit, "%"=20, "0–10"=2.5, "1–7"=1.2, "hours"=8, "per month"=6, "z-score"=1, 8)
  y_center <- switch(sc$vars$y$unit, "per 1,000"=20, "per week"=60, "0–100"=60, "1–7"=4, "%"=30, "count"=6, 60)
  y_scale  <- switch(sc$vars$y$unit, "per 1,000"=8, "per week"=14, "0–100"=15, "1–7"=1.2, "%"=12, "count"=3, 12)
  Xv <- scale_by_unit(Xz, x_center, x_scale)
  Yv <- scale_by_unit(Yz, y_center, y_scale)
  df <- tibble::tibble(
    Entity = paste0(ifelse(grepl("police|procedural|trust|calls|patrol", tolower(sc$title)), "Precinct ",
                           ifelse(grepl("neighborhood|burglary|disorder|fear|guardianship|victim", tolower(sc$title)), "Neighborhood ", "Unit ")),
                    seq_len(n)),
    !!xname := Xv,
    !!yname := Yv
  )
  # extras (scenario-related names, linear combos of Xz,Yz + noise)
  need <- max(0, k_total - 2L)
  if (need > 0) {
    names_pool <- sc$extras %||% rnd_name_list(need)
    if (length(names_pool) < need) names_pool <- c(names_pool, rnd_name_list(need - length(names_pool)))
    names_pool <- make.unique(names_pool)[1:need]
    for (j in seq_len(need)) {
      wX <- sample(c(0.6, 0.4, 0.3, -0.3), 1)
      wY <- sample(c(0.2, 0.3, -0.2, 0.0), 1)
      Z  <- wX*Xz + wY*Yz + rnorm(n, 0, 0.6)
      df[[names_pool[j]]] <- round(50 + 12*as.numeric(scale(Z)), 2)
    }
  }
  df
}

# truth helpers
calc_truth_basic <- function(vec) {
  m <- mean(vec)
  d <- vec - m; d2 <- d^2
  list(mean=m, dev=d, dev2=d2, sum_dev2=sum(d2), sd=sqrt(sum(d2)/(length(vec)-1)))
}

# steps card (exact 1–15 list)
steps_en_html <- function() HTML(paste0(
  "<div class='accent'><b>Steps for a bivariate regression (manual, EN)</b><ol style='margin:6px 0 0 18px;'>",
  "<li>Compute the arithmetic mean of X and Y.</li>",
  "<li>Compute each unit’s deviation from the mean for X and for Y.</li>",
  "<li>Square those deviations (builds variation in X and Y and the cross-product base).</li>",
  "<li>Sum the squared deviations for X and for Y.</li>",
  "<li>Compute Var(X) and Var(Y) by dividing those sums by (n − 1).</li>",
  "<li>Take square roots to get SD(X) and SD(Y).</li>",
  "<li>Compute the cross-product sum Σ(X−X̄)(Y−Ȳ) (covariation).</li>",
  "<li>Divide by (n − 1) to get Cov(X, Y).</li>",
  "<li>Compute SD(X) × SD(Y).</li>",
  "<li>Correlation r = Cov(X,Y) / (SD(X)×SD(Y)).</li>",
  "<li>Unstandardized slope b = Cov(X,Y) / Var(X).</li>",
  "<li>Intercept a = Ȳ − b·X̄.</li>",
  "<li>Predicted value Ŷ = a + b·X (e.g., choose any X).</li>",
  "<li>Determination coefficient R² = r² (bivariate case).</li>",
  "<li>Alienation coefficient = 1 − R² (share of Y not explained by X).</li>",
  "</ol>",
  "<div class='muted' style='margin-top:6px;'>For <b>multiple regression</b> (Y ~ X<sub>1</sub>,…,X<sub>k</sub>) follow the same Δ-steps for each X vs Y, and also compute Σ(ΔX<sub>i</sub>·ΔX<sub>j</sub>).</div>",
  "</div>"
))

# ---------- UI ----------
ui <- fluidPage(
  tags$head(tags$title("Criminology Scenarios — Manual Correlation & Regression")),
  tags$head(tags$style(HTML('
    body{background:linear-gradient(180deg,#F6FAFF 0%,#F9F7FF 100%);} 
    .card{background:#fff;border-radius:16px;padding:14px 16px;box-shadow:0 6px 18px rgba(0,0,0,0.08);} 
    .muted{color:#666;} .ok{color:#0E7C7B;font-weight:700;} .err{color:#B00020;font-weight:600;} 
    .btn-wide{min-width:220px;} .disabled{opacity:.5;pointer-events:none;}
    .accent{background:#E3F2FD;border-left:4px solid #42A5F5;padding:8px 10px;border-radius:10px;}
    .title{font-weight:800;color:#3F51B5;}
    .traffic{display:flex;gap:8px;margin-top:8px}
    .light{width:12px;height:12px;border-radius:50%;display:inline-block;background:#BDBDBD;}
    .feedback{color:#B00020;font-weight:600;margin-top:4px;}
    input.invalid{border:2px solid #D50000 !important; box-shadow:0 0 0 2px rgba(213,0,0,0.10) inset;}
    input.valid{border:2px solid #00C853 !important; box-shadow:0 0 0 2px rgba(0,200,83,0.10) inset;}
    .grid-compact{display:grid;grid-template-columns:repeat(2,1fr);gap:6px;}
    .grid-compact-3{display:grid;grid-template-columns:repeat(3,1fr);gap:6px;}
  '))),
  
  titlePanel(div(class="title","Criminology Scenarios — Manual Correlation & Regression")),
  
  sidebarLayout(
    sidebarPanel(width = 4,
                 # 1) How it works
                 div(class="card",
                     h4("How this app works"),
                     HTML("<ul style='margin:6px 0 0 16px;'>
          <li>Practice manual correlation & regression on small criminology datasets.</li>
          <li>Choose <b>Bivariate</b> (X,Y) or <b>Multiple</b> (Y ~ up to 4 X’s). Datasets can include <b>2–10</b> variables.</li>
          <li>Study the dataset (read-only). Then complete steps <b>1–15</b> by hand (4 decimals).</li>
          <li>Boxes only turn red when something you typed is off (neutral at start).</li>
          <li>When everything is correct, graphs and a plain-language interpretation appear.</li>
        </ul>")
                 ),
                 
                 br(),
                 # 2) Scenario & dataset
                 div(class="card",
                     h4("Scenario & dataset"),
                     radioButtons("mode","Analysis type", choices=c("Bivariate","Multiple"), inline=TRUE),
                     selectInput("scenario", "Scenario",
                                 choices = c("Random criminology scenario" = "__random__", scenario_choices)),
                     numericInput("num_vars", "Number of variables in dataset (2–10)", value = 4, min = 2, max = 10, step = 1),
                     numericInput("n", "Sample size N (0–50)", value = 20, min = 0, max = 50, step = 1),
                     textInput("seed", "Dataset code (seed, optional)", value = ""),
                     fluidRow(
                       column(6, actionButton("gen", "Generate dataset", class="btn btn-success btn-wide")),
                       column(6, actionButton("new_same", "New (same scenario)", class="btn btn-default btn-wide"))
                     ),
                     uiOutput("seed_echo"),
                     uiOutput("multi_picker")
                 ),
                 
                 br(),
                 # 3) Task & vignette (+ concepts)
                 div(class="card",
                     h4("Task & vignette"),
                     uiOutput("vignette_block")
                 ),
                 
                 br,
                 # 4) Steps card
                 div(class="card",
                     h4("Steps (EN)"),
                     steps_en_html()
                 )
    ),
    
    mainPanel(
      div(class="card",
          h4("Step 1 — Dataset (read-only)"),
          rHandsontableOutput("data_view")
      ),
      br(),
      
      # Step 2 — Means & SDs
      div(class="card",
          h4("Step 2 — Means & SDs (4 dp)"),
          uiOutput("labels_vars"),
          uiOutput("means_sds_ui"),
          div(class="traffic",
              span(class="light", id="light_means"), span(" Steps 1–6 (means, SDs)")
          )
      ),
      br(),
      
      # Step 3 — Row-wise deviations & cross-products
      div(class="card",
          h4("Step 3 — Row-wise calculations (4 dp)"),
          helpText("Fill each column exactly; headers match the formula notation used in class."),
          rHandsontableOutput("calc_table"),
          br(),
          checkboxInput("auto_check", "Auto-check as I type", TRUE),
          actionButton("check_btn", "✅ Check now", class="btn btn-primary btn-wide"),
          uiOutput("feedback_block"),
          div(class="traffic", span(class="light", id="light_rows"), span(" Steps 2–3 & 7"))
      ),
      br(),
      
      # Step 4 — Totals (4 dp)
      div(class="card",
          h4("Step 4 — Totals (4 dp)"),
          uiOutput("totals_ui"),
          div(class="traffic",
              span(class="light", id="light_totals"), span(" Steps 4, 7–8")
          )
      ),
      br(),
      
      # Step 5 — Visualizations & Summary
      div(class="card",
          h4("Step 5 — Visualizations & Summary (unlocks when correct)"),
          div(id="viz_block", class="disabled",
              uiOutput("plot_block"),
              uiOutput("stats_block"),
              uiOutput("interpret_block"),
              uiOutput("prediction_block")
          )
      )
    )
  )
)

# ---------- Server ----------
server <- function(input, output, session){
  current <- reactiveVal(tibble::tibble())
  yvar <- reactiveVal(NULL)
  xvars <- reactiveVal(character(0))
  user_calc_tbl <- reactiveVal(NULL)
  unlocked <- reactiveVal(FALSE)
  
  # seed echo
  output$seed_echo <- renderUI({
    ss <- safe_seed(input$seed)
    if (!is.null(ss)) div(class="muted", paste0("Seed: ", ss))
    else div(class="muted", "Seed: (none or invalid → using random)")
  })
  
  vignette_html <- function(sc_or_random) {
    if (identical(sc_or_random, "__random__")) {
      HTML("<div class='accent'>
        <b>Random criminology scenario.</b><br>
        <b>Your task:</b> follow steps 1–15 manually. In Multiple mode also compute cross-products between predictors.
      </div>")
    } else {
      sc <- sc_or_random
      primers <- concepts_for(sc$id)
      primer_html <- if (length(primers)) paste0("<hr style='margin:8px 0'>",
                                                 "<b>Concepts (quick primer):</b><ul style='margin:6px 0 0 16px;'><li>",
                                                 paste(primers, collapse='</li><li>'), "</li></ul>") else ""
      HTML(paste0(
        "<div class='accent'><b>", sc$title, "</b><br>",
        sc$vignette, primer_html, "</div>"
      ))
    }
  }
  output$vignette_block <- renderUI({
    if (identical(input$scenario, "__random__")) vignette_html("__random__") else vignette_html(get_sc(input$scenario))
  })
  
  # dataset creation & reset
  clamp <- function(x, lo, hi) max(lo, min(hi, x))
  new_data <- function(same = FALSE){
    n <- clamp(as.integer(input$n), 0, 50)
    nv <- clamp(as.integer(input$num_vars), 2, 10)
    raw <- input$seed; ss <- safe_seed(raw)
    if (!same || is.null(ss)) ss <- sample(1e9, 1)
    df <- if (identical(input$scenario, "__random__")) {
      make_random_multi(n = n, seed = ss, k = nv)
    } else {
      make_scenario_data(get_sc(input$scenario), n = n, seed = ss, k_total = nv)
    }
    current(df)
    updateTextInput(session, "seed", value = as.character(ss))
    # defaults
    vars <- names(df)[-1]
    if (length(vars) == 0) { yvar(NULL); xvars(character(0)) }
    else if (identical(input$mode, "Bivariate")) {
      yvar(vars[min(2,length(vars))]); xvars(vars[1])
    } else {
      y_default <- vars[min(2,length(vars))]
      x_default <- setdiff(vars, y_default)[1:min(2, max(1, length(vars)-1))]
      yvar(y_default); xvars(x_default)
    }
    user_calc_tbl(NULL); unlocked(FALSE)
    session$sendCustomMessage("toggleViz", FALSE)
    session$sendCustomMessage("paintLight", list(id="light_means", col="#BDBDBD"))
    session$sendCustomMessage("paintLight", list(id="light_rows", col="#BDBDBD"))
    session$sendCustomMessage("paintLight", list(id="light_totals", col="#BDBDBD"))
  }
  
  observeEvent(input$gen, new_data(FALSE))
  observeEvent(input$new_same, new_data(TRUE))
  observeEvent(list(input$n, input$num_vars, input$scenario, input$mode), { new_data(TRUE) })
  
  # Multiple-mode variable picker
  output$multi_picker <- renderUI({
    df <- current(); if (is.null(df) || nrow(df)==0) return(NULL)
    if (!identical(input$mode, "Multiple")) return(NULL)
    vars <- names(df)[-1]
    sel_y <- yvar() %||% vars[1]
    sel_x <- xvars()
    tagList(
      tags$hr(),
      h5("Choose variables (Multiple)"),
      selectInput("y_sel", "Y (outcome)", choices = vars, selected = sel_y),
      checkboxGroupInput("x_sel", "Predictors X (choose up to 4)",
                         choices = setdiff(vars, input$y_sel %||% sel_y),
                         selected = sel_x, inline = FALSE)
    )
  })
  observeEvent(input$y_sel, {
    yvar(input$y_sel)
    if (!is.null(input$x_sel)) {
      xs <- setdiff(input$x_sel, input$y_sel)
      if (length(xs) > 4) xs <- xs[1:4]
      xvars(xs)
    }
  })
  observeEvent(input$x_sel, {
    xs <- input$x_sel %||% character(0)
    if (!is.null(input$y_sel)) xs <- setdiff(xs, input$y_sel)
    if (length(xs) > 4) xs <- xs[1:4]
    xvars(xs)
  })
  
  # Labels + mapping to generic names
  output$labels_vars <- renderUI({
    df <- current(); if (is.null(df) || nrow(df)==0) return(NULL)
    y <- yvar(); xs <- xvars()
    if (identical(input$mode, "Bivariate")) {
      HTML(paste0("<b>Generic mapping:</b> X = ", xs[1], " &nbsp;&nbsp; Y = ", y))
    } else {
      gen <- paste0(mapply(function(i, nm) paste0(Xk(i), " = ", nm), seq_along(xs), xs), collapse=", ")
      HTML(paste0("<b>Generic mapping:</b> Y = ", y, " &nbsp;&nbsp; ", gen))
    }
  })
  
  # ---------- dynamic means/SDs inputs ----------
  output$means_sds_ui <- renderUI({
    df <- current(); if (is.null(df) || nrow(df)==0) return(NULL)
    y <- yvar(); xs <- xvars()
    if (is.null(y) || length(xs)==0) return(NULL)
    gen_names <- c(if (identical(input$mode,"Bivariate")) "X" else sapply(seq_along(xs), Xk), "Y")
    real_vars <- c(xs, y)
    tagList(
      div(class = if (length(real_vars)>2) "grid-compact-3" else "grid-compact",
          lapply(seq_along(real_vars), function(idx){
            lab <- gen_names[idx]; vid <- safe_id(lab)
            tagList(
              numericInput(paste0("mean_", vid), label = HTML(paste0("Mean of <b>", lab, "</b>")), value = NA, step = 0.0001),
              uiOutput(paste0("msg_mean_", vid)),
              numericInput(paste0("sd_", vid), label = HTML(paste0("SD of <b>", lab, "</b>")), value = NA, step = 0.0001),
              uiOutput(paste0("msg_sd_", vid))
            )
          })
      )
    )
  })
  
  # ---------- dataset table ----------
  output$data_view <- renderRHandsontable({
    df <- current(); if (is.null(df) || nrow(df)==0) return(NULL)
    rhandsontable(df, rowHeaders = FALSE, readOnly = TRUE)
  })
  
  # ---------- row-wise table (INTERNAL KEYS + DISPLAY HEADERS) ----------
  build_blank_calc <- function(){
    df <- current(); if (is.null(df) || nrow(df)==0) return(NULL)
    y <- yvar(); xs <- xvars()
    if (is.null(y) || length(xs)==0) return(NULL)
    # INTERNAL column names:
    # Entity, Y, X1..Xk, dY, dY2, (for X1: dX1, dX12, dX1dY), Yhat (bivariate)
    tbl <- tibble::tibble(Entity = df$Entity, Y = df[[y]])
    for (i in seq_along(xs)) tbl[[paste0("X", i)]] <- df[[xs[i]]]
    tbl[["dY"]]  <- NA_real_
    tbl[["dY2"]] <- NA_real_
    # we display/check only X1 columns in the row-wise grid to match screenshot
    tbl[["dX1"]]   <- NA_real_
    tbl[["dX12"]]  <- NA_real_
    tbl[["dX1dY"]] <- NA_real_
    if (identical(input$mode, "Bivariate")) tbl[["Yhat"]] <- NA_real_
    tbl
  }
  display_headers_for <- function(){
    ylab1 <- "yᵢ − ȳ"; ylab2 <- "(yᵢ − ȳ)^2"
    function(k){
      xlab1 <- paste0("x", sub_num(k), " − x̄")
      xlab2 <- paste0("(", xlab1, ")^2")
      xylab <- paste0("(", xlab1, ")(", ylab1, ")")
      list(ylab1=ylab1, ylab2=ylab2, xlab1=xlab1, xlab2=xlab2, xylab=xylab)
    }
  }
  output$calc_table <- renderRHandsontable({
    tbl <- user_calc_tbl(); if (is.null(tbl)) tbl <- build_blank_calc()
    if (is.null(tbl)) return(NULL)
    xs <- xvars()
    hdr <- c("Entity","Y", if (length(xs)>=1) "X₁" else "X")
    H <- display_headers_for()
    hdr <- c(hdr, H(1)$ylab1, H(1)$ylab2, H(1)$xlab1, H(1)$xlab2, H(1)$xylab)
    internal <- c("Entity","Y","X1","dY","dY2","dX1","dX12","dX1dY")
    if (identical(input$mode,"Bivariate")) {
      hdr <- c(hdr, "Predictie Y op basis van X")
      internal <- c(internal, "Yhat")
    }
    rhandsontable(tbl[, internal, drop=FALSE], rowHeaders = FALSE, stretchH = "all",
                  colHeaders = hdr) %>%
      rhandsontable::hot_cols(
        renderer = '
          function(instance, td, row, col, prop, value, cellProperties) {
            Handsontable.renderers.TextRenderer.apply(this, arguments);
            var hdr = instance.getColHeader(col);
            if (hdr !== "Entity" && value !== null && value !== "") {
              var num = Number(value);
              if (!isNaN(num)) td.innerText = num.toFixed(4);
            }
          }'
      ) %>%
      rhandsontable::hot_col(col = setdiff(internal, "Entity"), type = "numeric", format = "0.0000", allowInvalid = TRUE)
  })
  observeEvent(input$calc_table, { if (!is.null(input$calc_table)) user_calc_tbl(hot_to_r(input$calc_table)) })
  
  # ---------- totals UI ----------
  output$totals_ui <- renderUI({
    df <- current(); if (is.null(df) || nrow(df)==0) return(NULL)
    y <- yvar(); xs <- xvars()
    if (is.null(y) || length(xs)==0) return(NULL)
    if (identical(input$mode, "Bivariate")) {
      tagList(
        numericInput("tot_Y2", HTML("Σ(ΔY)²"), value = NA, step = 0.0001), uiOutput("msg_tot_Y2"),
        numericInput("tot_X1_2", HTML("Σ(ΔX₁)²"), value = NA, step = 0.0001), uiOutput("msg_tot_X1_2"),
        numericInput("tot_X1Y", HTML("Σ(ΔX₁·ΔY)"), value = NA, step = 0.0001), uiOutput("msg_tot_X1Y")
      )
    } else {
      xs_gen <- sapply(seq_along(xs), Xk)
      elements <- list(
        tags$b("Totals to enter (Multiple):"),
        tags$div(class="muted","Enter sums at 4 dp based on your Δ columns."),
        numericInput("tot_Y2", HTML("Σ(ΔY)²"), value = NA, step = 0.0001), uiOutput("msg_tot_Y2")
      )
      for (i in seq_along(xs_gen)) {
        g <- xs_gen[i]
        elements <- append(elements, list(
          numericInput(paste0("tot_", g, "_2"), HTML(paste0("Σ(Δ", g, ")²")), value = NA, step = 0.0001),
          uiOutput(paste0("msg_tot_", g, "_2")),
          numericInput(paste0("tot_", g, "Y"), HTML(paste0("Σ(Δ", g, "·ΔY)")), value = NA, step = 0.0001),
          uiOutput(paste0("msg_tot_", g, "Y"))
        ))
      }
      if (length(xs_gen) >= 2) {
        elements <- append(elements, list(tags$hr(), tags$b("Between-predictor cross-products")))
        for (i in 1:(length(xs_gen)-1)) for (j in (i+1):length(xs_gen)) {
          id <- paste0("tot_", xs_gen[i], xs_gen[j])
          elements <- append(elements, list(
            numericInput(id, HTML(paste0("Σ(Δ", xs_gen[i], "·Δ", xs_gen[j], ")")), value = NA, step = 0.0001),
            uiOutput(paste0("msg_", id))
          ))
        }
      }
      do.call(tagList, elements)
    }
  })
  
  # ----- feedback helpers -----
  mark_field <- function(id, ok, msg_id, ok_msg = "", err_msg = "") {
    state <- if (isTRUE(ok)) "valid" else if (identical(ok, FALSE)) "invalid" else "neutral"
    session$sendCustomMessage("markField", list(id = id, state = state))
    output[[msg_id]] <- renderUI({
      if (identical(state, "invalid")) div(class="feedback", err_msg)
      else HTML("")
    })
  }
  paint <- function(id, col){ session$sendCustomMessage("paintLight", list(id=id, col=col)) }
  
  # ----- reactive checker -----
  do_check <- reactiveVal(0)
  bump <- function(){ do_check(isolate(do_check())+1) }
  observeEvent(input$check_btn, bump())
  observeEvent(reactiveValuesToList(input), { if (isTRUE(input$auto_check)) bump() })
  
  # ----- main validator -----
  output$feedback_block <- renderUI({
    req(do_check())
    df <- current(); if (is.null(df) || nrow(df)==0) return(NULL)
    y <- yvar(); xs <- xvars(); if (is.null(y) || length(xs)==0) return(NULL)
    
    # Means/SDs
    vec_for <- function(lbl){
      if (lbl == "Y") return(df[[y]])
      if (grepl("^X", lbl)) {
        idx <- as.integer(gsub("[^0-9]", "", lbl)); if (is.na(idx)) idx <- 1L
        return(df[[ xs[idx] ]])
      }
      stop("Unknown label")
    }
    labs <- c(if (identical(input$mode,"Bivariate")) "X" else sapply(seq_along(xs), Xk), "Y")
    means_ok <- sds_ok <- TRUE
    for (lab in labs) {
      tru <- calc_truth_basic(vec_for(lab))
      okm <- check_decimals(input[[paste0("mean_", safe_id(lab))]], tru$mean, 4)
      oks <- check_decimals(input[[paste0("sd_",   safe_id(lab))]], tru$sd,   4)
      mark_field(paste0("mean_", safe_id(lab)), okm, paste0("msg_mean_", safe_id(lab)),
                 err_msg = paste0("Mean of ", lab, " seems off (step 1; 4 dp)."))
      mark_field(paste0("sd_",   safe_id(lab)), oks, paste0("msg_sd_",   safe_id(lab)),
                 err_msg = paste0("SD of ", lab, " seems off (steps 5–6; 4 dp)."))
      means_ok <- means_ok && isTRUE(okm)
      sds_ok   <- sds_ok   && isTRUE(oks)
    }
    paint("light_means", if (means_ok && sds_ok) "#00C853" else "#BDBDBD")
    if (!(means_ok && sds_ok)) {
      unlocked(FALSE); session$sendCustomMessage("toggleViz", FALSE)
      paint("light_rows", "#BDBDBD"); paint("light_totals", "#BDBDBD")
      return(div(class="err","Some means/SDs need attention."))
    }
    
    # Row-wise expectations (use student's means)
    tbl <- user_calc_tbl(); if (is.null(tbl)) tbl <- build_blank_calc()
    if (is.null(tbl)) return(NULL)
    meanY <- input$mean_Y
    dY <- tbl[["Y"]] - meanY
    ok_rows <- TRUE
    
    # Y Δ and Δ²
    if ("dY" %in% names(tbl)) {
      okv <- check_col_vec(round(tbl[["dY"]],4), round(dY,4), 4)
      if (any(!isTRUE(okv), na.rm=TRUE)) ok_rows <- FALSE
    }
    if ("dY2" %in% names(tbl)) {
      okv <- check_col_vec(round(tbl[["dY2"]],4), round(dY^2,4), 4)
      if (any(!isTRUE(okv), na.rm=TRUE)) ok_rows <- FALSE
    }
    # X₁ (to mirror your screenshot grid)
    meanX1 <- input$mean_X
    if (is.null(meanX1) || is.na(meanX1)) meanX1 <- input$mean_X1 %||% NA
    dX1 <- tbl[["X1"]] - meanX1
    if ("dX1" %in% names(tbl)) {
      okv <- check_col_vec(round(tbl[["dX1"]],4), round(dX1,4), 4)
      if (any(!isTRUE(okv), na.rm=TRUE)) ok_rows <- FALSE
    }
    if ("dX12" %in% names(tbl)) {
      okv <- check_col_vec(round(tbl[["dX12"]],4), round(dX1^2,4), 4)
      if (any(!isTRUE(okv), na.rm=TRUE)) ok_rows <- FALSE
    }
    if ("dX1dY" %in% names(tbl)) {
      okv <- check_col_vec(round(tbl[["dX1dY"]],4), round(dX1*dY,4), 4)
      if (any(!isTRUE(okv), na.rm=TRUE)) ok_rows <- FALSE
    }
    # Predicted Ŷ check (optional)
    if (identical(input$mode, "Bivariate") && "Yhat" %in% names(tbl)) {
      fit <- lm(current()[[y]] ~ current()[[xvars()[1]]])
      a <- as.numeric(coef(fit)[1]); b <- as.numeric(coef(fit)[2])
      # If student filled Yhat column, check it to 2 dp
      if (any(!is.na(tbl$Yhat))) {
        okv <- mapply(function(x, xx) check_decimals(x, a + b*xx, 2, tol = 0.5*10^-2),
                      tbl$Yhat, tbl$X1)
        if (any(!isTRUE(okv), na.rm=TRUE)) ok_rows <- FALSE
      }
    }
    
    paint("light_rows", if (ok_rows) "#00C853" else "#BDBDBD")
    if (!ok_rows) {
      unlocked(FALSE); session$sendCustomMessage("toggleViz", FALSE)
      paint("light_totals", "#BDBDBD")
      return(div(class="err","Row-wise Δ/Δ²/ΔX·ΔY have mistakes. Check highlighted columns."))
    }
    
    # Totals
    exp_Y2 <- sum((dY)^2)
    tot_ok <- TRUE
    mark_field("tot_Y2", check_decimals(input$tot_Y2, exp_Y2, 4), "msg_tot_Y2",
               err_msg = "Σ(ΔY)² seems off. Re-add your Y Δ² (4 dp).")
    tot_ok <- tot_ok && isTRUE(check_decimals(input$tot_Y2, exp_Y2, 4))
    exp_X12 <- sum(dX1^2)
    exp_X1Y <- sum(dX1*dY)
    mark_field("tot_X1_2", check_decimals(input$tot_X1_2, exp_X12, 4), "msg_tot_X1_2",
               err_msg = "Σ(ΔX₁)² seems off (4 dp).")
    mark_field("tot_X1Y", check_decimals(input$tot_X1Y, exp_X1Y, 4), "msg_tot_X1Y",
               err_msg = "Σ(ΔX₁·ΔY) seems off (4 dp).")
    tot_ok <- tot_ok &&
      isTRUE(check_decimals(input$tot_X1_2, exp_X12, 4)) &&
      isTRUE(check_decimals(input$tot_X1Y,  exp_X1Y, 4))
    
    paint("light_totals", if (tot_ok) "#00C853" else "#BDBDBD")
    
    if (means_ok && sds_ok && ok_rows && tot_ok) {
      unlocked(TRUE); session$sendCustomMessage("toggleViz", TRUE)
      div(div(class="ok","✅ Great! Everything checks out. Visuals and summary unlocked."))
    } else {
      unlocked(FALSE); session$sendCustomMessage("toggleViz", FALSE)
      div(class="err","Some entries still need attention (see red highlights/messages).")
    }
  })
  
  # ---------- Plots ----------
  output$plot_block <- renderUI({
    if (!isTRUE(unlocked())) return(NULL)
    if (identical(input$mode, "Bivariate")) {
      tagList(
        plotOutput("scatter_plot", height = 330),
        plotOutput("resid_plot", height = 210),
        plotOutput("calib_plot", height = 210)
      )
    } else {
      tagList(
        plotOutput("resid_plot_multi", height = 230),
        plotOutput("calib_plot_multi", height = 230)
      )
    }
  })
  output$scatter_plot <- renderPlot({
    req(unlocked()); df <- current(); x <- xvars()[1]; y <- yvar()
    ggplot(df, aes(.data[[x]], .data[[y]])) +
      geom_point(size=3, alpha=.95) +
      geom_smooth(method="lm", se=FALSE, linewidth=1.4) +
      labs(x=x, y=y) + theme_minimal(base_size=13)
  })
  output$resid_plot <- renderPlot({
    req(unlocked()); df <- current(); x <- xvars()[1]; y <- yvar(); fit <- lm(df[[y]] ~ df[[x]])
    ggplot(data.frame(X=df[[x]], Resid=residuals(fit)), aes(X, Resid)) +
      geom_hline(yintercept = 0, linetype = 2) +
      geom_point(size = 2.6) +
      labs(x = x, y = "Residuals (Y − Ŷ)") + theme_minimal(base_size = 12)
  })
  output$calib_plot <- renderPlot({
    req(unlocked()); df <- current(); x <- xvars()[1]; y <- yvar(); fit <- lm(df[[y]] ~ df[[x]])
    ggplot(data.frame(Yhat=fitted(fit), Y=df[[y]]), aes(Yhat, Y)) +
      geom_abline(slope = 1, intercept = 0, linetype = 2, linewidth=.8) +
      geom_point(size=2.8) +
      labs(x = "Predicted (Ŷ)", y = "Observed (Y)") + theme_minimal(base_size=12)
  })
  output$resid_plot_multi <- renderPlot({
    req(unlocked()); df <- current(); y <- yvar(); xs <- xvars()
    fit <- lm(df[[y]] ~ ., data = df[, c(y, xs), drop=FALSE])
    ggplot(data.frame(Yhat=fitted(fit), Resid=residuals(fit)), aes(Yhat, Resid)) +
      geom_hline(yintercept = 0, linetype = 2) +
      geom_point(size = 2.6) +
      labs(x = "Predicted (Ŷ)", y = "Residuals (Y − Ŷ)") + theme_minimal(base_size = 12)
  })
  output$calib_plot_multi <- renderPlot({
    req(unlocked()); df <- current(); y <- yvar(); xs <- xvars()
    fit <- lm(df[[y]] ~ ., data = df[, c(y, xs), drop=FALSE])
    ggplot(data.frame(Yhat=fitted(fit), Y=df[[y]]), aes(Yhat, Y)) +
      geom_abline(slope = 1, intercept = 0, linetype = 2, linewidth=.8) +
      geom_point(size=2.8) +
      labs(x = "Predicted (Ŷ)", y = "Observed (Y)") + theme_minimal(base_size=12)
  })
  
  # ---------- Stats + Interpretation ----------
  output$stats_block <- renderUI({
    req(unlocked()); df <- current(); y <- yvar(); xs <- xvars()
    if (identical(input$mode, "Bivariate")) {
      fit <- lm(df[[y]] ~ df[[xs[1]]])
      a <- coef(fit)[1]; b <- coef(fit)[2]
      r  <- cor(df[[xs[1]]], df[[y]]); r2 <- r^2
      yhat <- fitted(fit); yv <- df[[y]]
      SST <- sum((yv - mean(yv))^2); SSE <- sum((yv - yhat)^2); SSR <- SST - SSE
      se  <- sqrt(SSE / (nrow(df) - 2))
      HTML(sprintf(
        "<ul>
          <li><b>Intercept (a):</b> %.2f</li>
          <li><b>Slope (b):</b> %.2f</li>
          <li><b>Correlation (r):</b> %.2f &nbsp;&nbsp; <b>R²:</b> %.2f &nbsp;&nbsp; <b>Alienation:</b> %.2f</li>
          <li><b>Standard error of estimate:</b> %.2f</li>
          <li><b>SST:</b> %.2f • <b>SSR:</b> %.2f • <b>SSE:</b> %.2f</li>
        </ul>", a, b, r, r2, 1-r2, se, SST, SSR, SSE))
    } else {
      fit <- lm(df[[y]] ~ ., data = df[, c(y, xs), drop=FALSE])
      co <- coef(fit)
      yhat <- fitted(fit); yv <- df[[y]]
      SST <- sum((yv - mean(yv))^2); SSE <- sum((yv - yhat)^2); SSR <- SST - SSE
      r2 <- summary(fit)$r.squared; se <- sqrt(SSE / (nrow(df) - length(co)))
      lis <- c(sprintf("<li><b>Intercept (a):</b> %.2f</li>", co[1]))
      for (i in seq_along(xs)) lis <- c(lis, sprintf("<li><b>Slope (b<sub>%s</sub>):</b> %.2f</li>", Xk(i), co[i+1]))
      lis <- c(lis,
               sprintf("<li><b>R²:</b> %.2f</li>", r2),
               sprintf("<li><b>Standard error of estimate:</b> %.2f</li>", se),
               sprintf("<li><b>SST:</b> %.2f • <b>SSR:</b> %.2f • <b>SSE:</b> %.2f</li>", SST, SSR, SSE))
      HTML(paste0("<ul>", paste(lis, collapse=""), "</ul>"))
    }
  })
  
  output$interpret_block <- renderUI({
    req(unlocked()); df <- current(); y <- yvar(); xs <- xvars()
    if (identical(input$mode, "Bivariate")) {
      fit <- lm(df[[y]] ~ df[[xs[1]]]); b <- as.numeric(coef(fit)[2])
      r  <- as.numeric(cor(df[[xs[1]]], df[[y]])); r2 <- r^2
      direction <- if (r > 0) "positive" else if (r < 0) "negative" else "no"
      HTML(sprintf(
        "<div class='accent'><b>Interpretation:</b> We see a <b>%s</b> association (r = %.2f, R² = %.2f). 
         A 1-unit increase in <i>X</i> is linked with a <b>%.2f</b> change in <i>Y</i> on average. 
         About <b>%d%%</b> of the differences in <i>Y</i> can be described by <i>X</i>. Association ≠ causation.</div>",
        direction, r, r2, b, round(100*r2)))
    } else {
      fit <- lm(df[[y]] ~ ., data = df[, c(y, xs), drop=FALSE])
      co <- coef(fit); r2 <- summary(fit)$r.squared
      parts <- paste0("<li>Holding other predictors constant, a 1-unit increase in <i>",
                      sapply(seq_along(xs), Xk), "</i> changes <i>Y</i> by <b>", sprintf("%.2f", co[-1]), "</b> on average.</li>")
      HTML(paste0(
        "<div class='accent'><b>Interpretation (multiple):</b> Overall fit <b>R² = ", sprintf("%.2f", r2), "</b>.<ul>",
        paste(parts, collapse=""), "</ul>Association ≠ causation.</div>"
      ))
    }
  })
  
  # Bivariate prediction practice (Predictie Y op basis van X)
  output$prediction_block <- renderUI({
    if (!isTRUE(unlocked()) || !identical(input$mode, "Bivariate")) return(NULL)
    tagList(
      tags$hr(),
      h5("Predictie Y op basis van X (2 dp)"),
      fluidRow(
        column(4, numericInput("pred_x_in", "Choose X", value = NA, step = 0.01)),
        column(4, numericInput("pred_yhat_in", "Your Ŷ = a + b·X", value = NA, step = 0.01)),
        column(4, uiOutput("pred_feedback"))
      )
    )
  })
  output$pred_feedback <- renderUI({
    req(unlocked()); if (!identical(input$mode, "Bivariate")) return(NULL)
    df <- current(); x <- xvars()[1]; y <- yvar()
    fit <- lm(df[[y]] ~ df[[x]])
    a <- as.numeric(coef(fit)[1]); b <- as.numeric(coef(fit)[2])
    if (is.na(input$pred_x_in) || is.na(input$pred_yhat_in)) return(HTML(""))
    yhat_true <- a + b*input$pred_x_in
    ok <- check_decimals(input$pred_yhat_in, yhat_true, target_decimals = 2)
    if (isTRUE(ok)) div(class="ok","✅ Ŷ looks good.")
    else div(class="feedback","Ŷ doesn’t match a + b·X at 2 dp — try again.")
  })
  
  # JS inits
  session$onFlushed(function(){
    session$sendCustomMessage("toggleViz", FALSE)
    session$sendCustomMessage("paintLight", list(id="light_means", col="#BDBDBD"))
    session$sendCustomMessage("paintLight", list(id="light_rows", col="#BDBDBD"))
    session$sendCustomMessage("paintLight", list(id="light_totals", col="#BDBDBD"))
  }, once = TRUE)
}

# ---------- Head-level JS ----------
js <- tags$script(HTML("
  Shiny.addCustomMessageHandler('toggleViz', function(show){
    var el = document.getElementById('viz_block');
    if(!el) return;
    if(show){ el.classList.remove('disabled'); } else { el.classList.add('disabled'); }
  });
  Shiny.addCustomMessageHandler('paintLight', function(msg){
    var el = document.getElementById(msg.id);
    if(!el) return;
    el.style.background = msg.col || '#BDBDBD';
  });
  Shiny.addCustomMessageHandler('markField', function(msg){
    var el = document.getElementById(msg.id);
    if(!el) return;
    el.classList.remove('invalid','valid');
    if(msg.state === 'invalid'){ el.classList.add('invalid'); }
    if(msg.state === 'valid'){ el.classList.add('valid'); }
  });
"))
ui$children[[1]] <- tagAppendChild(ui$children[[1]], js)

shinyApp(ui, server)
