echo -e "establecer host de confianza para descarga de librerias...."

pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"

echo -e "instalar y actualizar wheel para archivos .whl......"

pip install -U pip setuptools wheel

echo -e "instalar y actualizar gestor de paquetes pip....."

yum install -y pip 

pip install --upgrade pip

echo -e "Actualizar Repositorio sagemaker......."

pip install --upgrade sagemaker


echo -e "establecer entorno y version de python..." 

pip install virtualenv

virtualenv -p python3.10 totalloss

source totalloss/bin/activate

pip install ipykernel

python -m ipykernel install --user --name totalloss



echo -e "Ejecutando librerias.........." 
pip install papermill

papermill /home/ec2-user/SageMaker/co-totalloss/librerias.ipynb /home/ec2-user/SageMaker/co-totalloss/librerias.ipynb


echo  -e "librerias listas...."


echo  -e "establecer conector odbc...."

# sudo su yum install -y unixODBC unixODBC-devel
sudo su - <<EOF

yum update -y

yum install -y unixODBC unixODBC-devel

curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

sudo ACCEPT_EULA=Y yum install -y msodbcsql18

EOF

echo -e "Entorno Listo.........." 


echo -e "Ejecutando Cuadernillo.........." 
papermill pipeline_totalloss.ipynb pipeline_totalloss.ipynb 

echo -e "Proceso ejecutado correctamente .........." 
