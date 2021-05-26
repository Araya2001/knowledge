Cargar un comando, en este caso, cambiar el editor al arranque de sqlplus:

```
# vi /u01/app/oracle/product/11.2.0/xe/sqlplus/admin/glogin.sql
```

```sql
-- Copyright (c) 1988, 2005, Oracle.  All Rights Reserved.
--

-- NAME

--   glogin.sql
--

-- DESCRIPTION

--   SQL*Plus global login "site profile" file
--

--   Add any SQL*Plus commands here that are to be executed when a

--   user starts SQL*Plus, or uses the SQL*Plus CONNECT command.
--

-- USAGE

--   This script is automatically run
--
define_editor=/usr/bin/vi -- Define el editor a vi, debe tener el PATH canónico
```


