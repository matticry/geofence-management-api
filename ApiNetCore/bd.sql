create table geogeoc
(
    geoccod   char(10)                                 not null comment 'codigo geocerca'
        primary key,
    geocnom   char(200)      default ''                not null comment 'nombre de geocerca',
    geocsec   char(50)       default ''                not null comment 'sector ',
    geocdirre char(100)      default ''                not null comment 'direccion referencia',
    geocciud  char(30)       default ''                not null comment 'ciudad ',
    geocprov  char(30)       default ''                not null comment 'provincia',
    geocpais  char(30)       default ''                not null comment 'pais ',
    geoclat   decimal(10, 8) default 0.00000000        not null comment 'latitud retferecnia ',
    geoclon   decimal(11, 8) default 0.00000000        not null comment 'longitud referencia ',
    geoccoor  json                                     null comment 'coordenadas ',
    geocarm   decimal(15, 2) default 0.00              not null comment 'area en metros',
    geocperm  decimal(10, 2) default 0.00              not null comment 'perimetro',
    geocest   char           default 'A'               not null comment 'estado de geocerca',
    geocact   tinyint(1)     default 1                 not null comment 'estdo activo=1 inactivo =0',
    geocpri   int            default 0                 not null comment 'prioridad',
    geocdesc  varchar(250)   default ''                not null comment 'descripcion',
    geocuscre char(50)       default ''                not null comment 'usuario crea',
    geocfcre  datetime       default CURRENT_TIMESTAMP not null comment 'fecha hora creacion',
    geoceqcre char(50)       default ''                not null comment 'equipo edita',
    geocusedi char(50)       default ''                not null comment 'usuario edita',
    geocfedi  datetime       default CURRENT_TIMESTAMP not null comment 'fecha y hora edicion',
    geoceqedi char(50)       default ''                not null comment 'equipo edita'
);

create table geogyu
(
    geugid    int auto_increment comment 'id relacion'
        primary key,
    geugidv   char(10)       default ''                not null comment 'id usuario',
    geugidg   char(10)       default ''                not null comment 'id geocerca',
    geuguscre char(10)       default ''                not null comment 'usuario crea',
    geugfcre  datetime       default CURRENT_TIMESTAMP not null comment 'fecha hora creacion',
    geugeqcre char(50)       default ''                not null comment 'equipo de creacion',
    geugusedi char(10)       default ''                not null comment 'usuario edita',
    geugfedi  datetime       default CURRENT_TIMESTAMP not null comment 'fecha y hora edicion',
    geugeqedi char(50)       default ''                not null comment 'equipo de edicion',
    geuglat   decimal(10, 8) default 0.00000000        null,
    geuglon   decimal(11, 8) default 0.00000000        null,
    constraint geogyu_geogeoc_geoccod_fk
        foreign key (geugidg) references geogeoc (geoccod)
);

create table georeg
(
    regid     int auto_increment comment 'id registro'
        primary key,
    regusu    char(10)    default ''                not null comment 'usuario registra',
    regtiptra int         default 0                 not null comment 'tipo transaccion 1=cobros 2=pedidos',
    regnum1   int         default 0                 not null comment 'numero 1',
    regnum2   int         default 0                 not null comment 'numero 2',
    regser1   char(30)    default ''                not null comment 'serie 1',
    regser2   char(30)    default ''                not null comment 'serie 2',
    regser3   char(30)    default ''                not null comment 'serie 3',
    reglat    decimal     default 0                 not null comment 'latitu',
    reglog    decimal(11) default 0                 not null comment 'longitud',
    regfech   datetime    default CURRENT_TIMESTAMP not null comment 'fecha registro',
    regcodcli char(13)    default ''                not null comment 'codigo cliente',
    regnomcli char(200)   default ''                not null comment 'nombre cleinte',
    regdirref char(100)   default ''                not null comment 'direccion referencia'
);

create table geosolcpc
(
    solid     int auto_increment comment 'id solicitud '
        primary key,
    solfech   datetime       default CURRENT_TIMESTAMP not null comment 'fecha de registro',
    solusu    char(10)       default ''                not null comment 'usuarios solicitud',
    solclave  char(13)       default ''                not null comment 'codigo de cliente a actualizar',
    solnombre char(10)       default ''                not null comment 'nombre de cliente a actualizar',
    solruc    char(10)       default ''                not null comment 'ruc de cliente a actualizar',
    solnumd   int            default 0                 not null comment 'numero de direccion 1 2 o 3',
    sollat    decimal(10, 8) default 0.00000000        not null comment 'latitu',
    sollog    decimal(11, 8) default 0.00000000        not null comment 'longitud',
    soliddb   int            default 0                 not null comment 'id base de datos donde se realiza el cambio',
    solnodb   char(20)       default ''                not null comment 'base de datos donde se realiza el cambio',
    soldiran  char(100)      default ''                not null comment 'direccion antigua',
    soldirnu  char(100)      default ''                not null comment 'direccion ingresada nueva direccion',
    solact    tinyint(1)     default 1                 not null comment 'estado de la solicitud 0=rechazado, 1=aprobado',
    solapli   tinyint(1)     default 0                 not null comment 'indicar si esta aplicado 1=si, 0=no'
);

create table geoubi
(
    geubid   int auto_increment comment 'id registro'
        primary key,
    geubusu  char(10)       default ''                not null comment 'usuario crea',
    geubfech datetime       default CURRENT_TIMESTAMP not null comment 'fecha registro',
    geublat  decimal(10, 8) default 0.00000000        not null comment 'latitud',
    geublon  decimal(11, 8) default 0.00000000        not null comment 'longitud'
);

