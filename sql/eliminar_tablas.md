**Eliminar Tablas**

Para seleccionar todas las tablas que el usuario local a creado, y borrarlas, copiar y pegar la siguiente linea

```sql
select 'drop table ', table_name, 'cascade constraints;' from user_tables;
```

La consulta realizada va a generar lo siguiente (Ejemplo)

```sql
SQL> select 'drop table ', table_name, 'cascade constraints;' from user_tables;

'DROPTABLE' TABLE_NAME			   'CASCADECONSTRAINTS;
----------- ------------------------------ --------------------
drop table  SERIETV			   cascade constraints;
drop table  SAGAS			   cascade constraints;
drop table  REPROXSERIE 		   cascade constraints;
drop table  REPROXPELI			   cascade constraints;
drop table  REPROXCANC			   cascade constraints;
drop table  REPARTOXSERIETV		   cascade constraints;
drop table  REPARTOXPELICULA		   cascade constraints;
drop table  PELICULAS			   cascade constraints;
drop table  PAISES			   cascade constraints;
drop table  PAGO			   cascade constraints;
drop table  GENEROS			   cascade constraints;
drop table  FAVSERIETV			   cascade constraints;
drop table  FAVPELICULA 		   cascade constraints;
drop table  FAVCANCION			   cascade constraints;
drop table  ESTUDIOS			   cascade constraints;
drop table  ESTILOS			   cascade constraints;
drop table  EPSERIE			   cascade constraints;
drop table  DESCXSERIE			   cascade constraints;
drop table  DESCXPELI			   cascade constraints;
drop table  DESCXCANC			   cascade constraints;
drop table  CLIENTES			   cascade constraints;
drop table  CANCIONES			   cascade constraints;
drop table  ARTXREPARTOTV		   cascade constraints;
drop table  ARTXREPARTO 		   cascade constraints;
drop table  ARTISTA			   cascade constraints;

25 rows selected.

```

Copiar y pegar los resultados de la consulta anterior, una vez realizado, ingresar la siguiente linea en caso de que haga uso de la papelera

```sql
select 'purge table ', '"'||table_name||'";' from cat;
```

Una vez ingresado, retornara lo siguiente

```sql
SQL> select 'purge table ', '"'||table_name||'";' from cat;

'PURGETABLE' '"'||TABLE_NAME||'";'
------------ ---------------------------------
purge table  "BIN$wzf9ihr/HIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihr5HIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihs2HIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihs7HIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihsIHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihsPHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihsWHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihsaHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihseHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihsrHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihswHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9iht+HIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtAHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtFHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtKHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtPHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtUHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtcHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtlHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtsHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihtzHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihuIHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihuNHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihuSHIzgUBSsAgAAhQ==$0";
purge table  "BIN$wzf9ihuZHIzgUBSsAgAAhQ==$0";

25 rows selected.

```

Copiar y pegar el resultado de la consulta anterior, eliminando las tablas de la papelera

**Adicional**

Darle formato a una serie de columnas:

Copiar o cargar la siguiente consulta (Ejemplo):

```sql
select columns
from (
	select 'column '||column_name||' format A20;' as columns from all_tab_columns where owner='ALFA'
	)
where columns not like '%ID%';
```

Al seleccionar todo lo retornado de la consulta anterior, copiar y pegar y le asignara un formato a cada columna que se encuentre bajo la condicion establecida