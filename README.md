# Portafolio de Datos — Francis Zapata

🌐 [Read this in English](./README.en.md)

Análisis de datos, Business Intelligence y modelado de decisiones, desarrollados en el marco de la Maestría en Análisis de Datos y BI (UDLA) y sus diplomados asociados (SQL, Análisis de Datos, Escuela Politécnica Nacional).

Contacto: francis.n.zapata.correa@gmail.com | Quito, Ecuador

---

## 1. Predicción de Rotación de Empleados
**Herramientas:** R (tidymodels)
**Carpeta:** [`rotacion-empleados-logistica/`](./rotacion-empleados-logistica)

Modelo de regresión logística para predecir si un empleado dejará la empresa (`left_company`), a partir de variables como horas semanales, años en la empresa, tiempo desde la última promoción y calificación de desempeño. Evaluado con matriz de confusión, sensibilidad (89.6%), especificidad (96.8%) y curva ROC (AUC = 0.99), con optimización del punto de corte mediante el índice de Youden.

## 2. Limpieza y Gobernanza de Datos No Estructurados
**Herramientas:** R (stringr, jsonlite)
**Carpeta:** [`limpieza-datos-policiales/`](./limpieza-datos-policiales)

Estandarización de un dataset de 10,051 registros de llamadas policiales de San Francisco, cuya columna de tipo de incidente contenía ~575 valores desordenados (códigos policiales, abreviaturas, errores tipográficos). Se aplicaron diccionarios de expresiones regulares para normalizar el texto, se creó una taxonomía propia de 14 categorías de crimen, se depuraron columnas redundantes y se exportó el resultado a JSON estructurado. Incluye un resumen ejecutivo con propuestas de mejora de calidad de datos: validación en el momento de captura, geocodificación para análisis geoespacial, e historial de auditoría de cambios.

## 3. Clustering de Empleados
**Herramientas:** Python (pandas, scikit-learn, seaborn)
**Carpeta:** [`clustering-empleados-python/`](./clustering-empleados-python)

Segmentación no supervisada de empleados (empresa ficticia "Creative HR") mediante K-Means, determinando el número óptimo de clusters con el método del codo y visualizando los resultados con PCA. Los clusters se perfilaron con gráficos de violín y se validaron con un clasificador Random Forest para identificar las variables más influyentes en la segmentación (ingreso mensual, satisfacción laboral, satisfacción en las relaciones laborales).

## 4. Análisis de Mercado Bursátil — Bolsa de Valores de Quito
**Herramientas:** Power BI
**Carpeta:** [`bolsa-quito-powerbi/`](./bolsa-quito-powerbi)

Informe multianual (2019–2023) sobre comisiones del mercado bursátil ecuatoriano, comparando la Bolsa de Valores de Quito y la de Guayaquil. Incluye análisis de Pareto para identificar las casas de valores que concentran el 80% de las comisiones, segmentación por tipo de instrumento financiero (renta fija/variable) y evolución de la participación de mercado por año.

## 5. Modelo de Optimización de Distribución Energética — ElectroLatam S.A.
**Herramientas:** AMPL, CPLEX, Excel Solver
**Carpeta:** [`electrolatam-optimizacion/`](./electrolatam-optimizacion)

Caso académico de investigación de operaciones: formulación y resolución de un modelo de transporte para minimizar el costo de distribución de energía eléctrica entre 3 plantas generadoras y 3 regiones. Incluye análisis de sensibilidad (precios sombra, costos reducidos) para dos escenarios: operación normal y alta demanda estacional.

## 6. Análisis de Abandono (Churn) de Usuarios — Spotify
**Herramientas:** R, Tableau
**Carpeta:** [`spotify-churn/`](./spotify-churn)

Proyecto grupal (3 integrantes, coordinación técnica a mi cargo) sobre un dataset de 8,000 usuarios de Spotify. Se diseñaron campos calculados (Puntaje de Compromiso, Puntaje de Riesgo, Índice de Retención) y un dashboard interactivo en Tableau con más de 10 visualizaciones para identificar los factores asociados al abandono de la plataforma: tipo de suscripción, dispositivo, hábitos de escucha y variables demográficas.

## 7. Modelado Predictivo de Riesgo Crediticio
**Herramientas:** R (tidymodels)
**Carpeta:** [`riesgo-crediticio-arboles/`](./riesgo-crediticio-arboles)

Comparación de 4 modelos de clasificación (Árbol de Decisión con poda por costo-complejidad, Bagging, Random Forest, QDA) para predecir incumplimiento de pago sobre el dataset "German Credit Data" (1,000 solicitudes de crédito), evaluando el desempeño con matrices de confusión, sensibilidad/especificidad y curvas ROC/AUC.

## 8. Administración de Bases de Datos NoSQL — MongoDB Atlas
**Herramientas:** MongoDB (mongosh, mongoimport/export, mongodump/restore)
**Carpeta:** [`mongodb-atlas/`](./mongodb-atlas)

Administración de un clúster en la nube (MongoDB Atlas): importación y exportación de colecciones, respaldo y restauración, y monitoreo en tiempo real (`mongostat`, `mongotop`). Se construyeron pipelines de agregación complejos (`$match`, `$group`, `$project`, `$filter`, `$addFields`, `$switch`) para consultas sobre datos anidados, y se aplicó un caso real de actualización masiva condicional sobre un dataset de terrazas de Madrid (más de 10 operaciones de actualización con lógica de negocio).

## 9. Diseño de Base de Datos Relacional — Sistema de Gestión Clínica
**Herramientas:** SQL
**Carpeta:** [`sql-sistema-clinico/`](./sql-sistema-clinico)

Modelado y creación de una base de datos relacional para una clínica (7 tablas con llaves foráneas: especialidad, subespecialidad, doctor, enfermedad, paciente, atención, cita), con ~200 registros de pacientes y 60 doctores. Se resolvieron consultas de negocio mediante `JOIN` y `GROUP BY`: pacientes por fecha, pacientes por doctor, enfermedad más frecuente y paciente con más enfermedades.

---

### Nota sobre los datos
Todos los datasets utilizados son sintéticos, de fuentes abiertas (Kaggle) o generados para fines académicos. Ningún proyecto utiliza datos reales de instituciones o personas identificables.
[README.md](https://github.com/user-attachments/files/30566549/README.md)


[README.en.md](https://github.com/user-attachments/files/30566553/README.en.md)# Data Portfolio — Francis Zapata

🌐 [Leer esto en Español](./README.md)

Data analysis, Business Intelligence, and decision modeling projects, developed as part of the Master's in Data Analysis and BI (UDLA) and its associated diploma programs (SQL, Data Analysis, Escuela Politécnica Nacional).

Contact: francis.n.zapata.correa@gmail.com | Quito, Ecuador

---

## 1. Employee Attrition Prediction
**Tools:** R (tidymodels)
**Folder:** [`rotacion-empleados-logistica/`](./rotacion-empleados-logistica)

Logistic regression model to predict whether an employee will leave the company (`left_company`), based on variables such as weekly hours, tenure, time since last promotion, and performance rating. Evaluated with a confusion matrix, sensitivity (89.6%), specificity (96.8%), and ROC curve (AUC = 0.99), with cutoff optimization via the Youden index.

## 2. Unstructured Data Cleaning & Governance
**Tools:** R (stringr, jsonlite)
**Folder:** [`limpieza-datos-policiales/`](./limpieza-datos-policiales)

Standardized a dataset of 10,051 San Francisco police call records, whose incident-type column contained ~575 messy values (police codes, abbreviations, typos). Applied regex dictionaries to normalize the text, built a custom 14-category crime taxonomy, cleaned up redundant columns, and exported the result to structured JSON. Includes an executive summary proposing data quality improvements: capture-time validation, geocoding for spatial analysis, and a change audit trail.

## 3. Employee Clustering
**Tools:** Python (pandas, scikit-learn, seaborn)
**Folder:** [`clustering-empleados-python/`](./clustering-empleados-python)

Unsupervised employee segmentation (fictional company "Creative HR") using K-Means, determining the optimal number of clusters with the elbow method and visualizing results with PCA. Clusters were profiled with violin plots and validated with a Random Forest classifier to identify the most influential variables in the segmentation (monthly income, job satisfaction, relationship satisfaction).

## 4. Stock Market Analysis — Quito Stock Exchange
**Tools:** Power BI
**Folder:** [`bolsa-quito-powerbi/`](./bolsa-quito-powerbi)

Multi-year report (2019–2023) on commissions in the Ecuadorian stock market, comparing the Quito and Guayaquil stock exchanges. Includes Pareto analysis to identify the brokerage firms concentrating 80% of commissions, segmentation by financial instrument type (fixed/variable income), and market share evolution by year.

## 5. Energy Distribution Optimization Model — ElectroLatam S.A.
**Tools:** AMPL, CPLEX, Excel Solver
**Folder:** [`electrolatam-optimizacion/`](./electrolatam-optimizacion)

Academic operations research case: formulation and solution of a transportation model to minimize the cost of electricity distribution across 3 generating plants and 3 regions. Includes sensitivity analysis (shadow prices, reduced costs) for two scenarios: normal operation and seasonal peak demand.

## 6. Spotify User Churn Analysis
**Tools:** R, Tableau
**Folder:** [`spotify-churn/`](./spotify-churn)

Group project (3 members, technical lead) analyzing an 8,000-user Spotify dataset. Designed calculated fields (Engagement Score, Risk Score, Retention Index) and an interactive Tableau dashboard with 10+ visualizations to identify factors associated with platform churn: subscription type, device, listening habits, and demographics.

## 7. Credit Risk Predictive Modeling
**Tools:** R (tidymodels)
**Folder:** [`riesgo-crediticio-arboles/`](./riesgo-crediticio-arboles)

Comparison of 4 classification models (pruned Decision Tree, Bagging, Random Forest, QDA) to predict loan default on the "German Credit Data" dataset (1,000 loan applications), evaluating performance with confusion matrices, sensitivity/specificity, and ROC/AUC curves.

## 8. NoSQL Database Administration — MongoDB Atlas
**Tools:** MongoDB (mongosh, mongoimport/export, mongodump/restore)
**Folder:** [`mongodb-atlas/`](./mongodb-atlas)

Administered a cloud cluster (MongoDB Atlas): collection import/export, backup and restore, and real-time monitoring (`mongostat`, `mongotop`). Built complex aggregation pipelines (`$match`, `$group`, `$project`, `$filter`, `$addFields`, `$switch`) for queries over nested data, and applied a real-world case of conditional bulk updates on a Madrid sidewalk-terrace dataset (10+ update operations with business logic).

## 9. Relational Database Design — Clinic Management System
**Tools:** SQL
**Folder:** [`sql-sistema-clinico/`](./sql-sistema-clinico)

Modeled and created a relational database for a clinic (7 tables with foreign keys: specialty, subspecialty, doctor, disease, patient, visit, appointment), with ~200 patient records and 60 doctors. Solved business queries using `JOIN` and `GROUP BY`: patients by date, patients by doctor, most frequent disease, and patient with the most diseases.

---

### Note on data
All datasets used are synthetic, from open sources (Kaggle), or generated for academic purposes. No project uses real data from institutions or identifiable individuals.



