# Modelo Total Loss 

- Nombre del proyecto: Total Loss 

- Autor: Analítica Colombia 

- Stakeholders: Omar Calderón – Miriam Burgos – Dayan Rodríguez – Jonathan Lozada 

- Periodicidad Corrida: Diaria – Días hábiles  

- Consolidado Alertas: **hdi-sagemaker-project-co/data-science/nppm-latam/totallossco/predictions/** 

 

# Descripción General 

Este proyecto realiza un procesamiento y análisis relacionados son los siniestros vehiculares para realizar una categorización por medio de un modelo XGBoost y definir si es siniestro corresponde a la categoría de **perdida total** o **perdida parcial**. Con el fin de realizar un ajuste en las reservas diariamente.  
 

# Insumos Principales 

Este modelo utiliza como insumo principal: 

- **Diario Leakage (.csv)** – El proceso de consulta y extracción de esta información se realiza por medio de AirFlow y este proceso es manejado por Javier Gualdrón. La información se disponibiliza diariamente y se debe tomar un periodo consolidado de 30 días atrás 

  - s3://hdi-sagemaker-project-co/data-science/nppm-latam/fraude/daily_claims_colombia/daily_claims_colombia_danios_test/ 

- **Joblib** – Contiene los resultados del entrenamiento del modelo XGBoost seleccionado para realizar las predicciones sobre los nuevos sets de datos 

  - co_totalloss.joblib

    - s3://hdi-sagemaker-project-co/data-science/nppm-latam/totallossco/Joblib_TL/   

# Resultados  

El resultado del modelo consiste en obtener una marca en los registros seleccionados del insumo principal que indique si un siniestro corresponderá a una **pérdida total** o a una **pérdida parcial** de acuerdo con sus características. Este es cargado en el S3 Consolidado Alertas como se menciona al inicio de este documento y se envía por correo a los stakeholders cada día en la mañana. 

# Contenido 

- **pipeline_totallos.ipynb**         <- script para correr el modelo, marcar los registros correspondientes y cargar los resultados al S3 definido para esto. 

 

- **00_sgmkr_init_totalloss.sh**      <- establece host de confianza, setea el ambiente, instala las librerías en las versiones requeridas, instala ODBC 

 

- **librerias.ipynb**      <- contiene las librerías con las versiones que se utilizaron en la construcción del pipeline 

 

- **totalloss_data_creation.ipynb &  totalloss_training.ipynb**  <- Cuadernillos para consulta del proceso de entrenamiento del modelo y las respectivas fuentes de datos. 

 

- **Co_totalloss.db**   <- Base de datos que contiene los hiperparámetros del modelo 

# Ejecución Modelo 

Para la configuración del entorno virtual y ejecución del pipeline, ejecutar **00_sgmkr_init_totalloss.sh**. Es importante asegurarse que, en este archivo, siempre se relacionen las versiones requeridas para la correcta ejecución del proceso, para esto, se puede consultar el archivo librerias.ipynb       

1. Abrir terminal. 

2. Introducir el comando ls y validar que el archivo 00_sgmkr_init_totalloss.sh esté habilitado para ejecución (en el listado de archivos, el nombre deberá aparecer en color verde). En caso contrario, utilizar el comando chmod +x 00_sgmkr_init_totalloss.sh y volver a realizar la validación. 

3. Ejecutar el .sh utilizando el comando bash 00_sgmkr_init_totalloss.sh 

4. Validar que el resultado quede cargado en el S3 correspondiente 

5. Descargar el archivo que contiene el resultado Ej: perdidas_totales_14_01_25.xlsx y enviarlo por correo a los stakeholders + Datacontrolycalidad@Libertycolombia.com 
