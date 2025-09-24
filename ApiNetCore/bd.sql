﻿create table tbl_document_type
(
    id_d_t        int identity
        constraint tbl_document_type_pk
            primary key,
    name_document varchar(250),
    code          varchar(5)
)
    go

create table tbl_electronic_voucher
(
    id_e_v                int identity
        constraint tbl_electronic_voucher_pk
            primary key,
    access_key            varchar(250),
    status_code           char,
    id_voucher            int
        constraint tbl_electronic_voucher_tbl_document_type_id_d_t_fk
            references tbl_document_type,
    message               varchar(250),
    identifier            varchar(250),
    type                  varchar(100),
    datetime_autorization datetime,
    aditional_info        text
)
    go

create table tbl_enterprise
(
    id_en                int identity
        constraint tbl_enterprise_pk
            primary key,
    company_name         varchar(250),
    comercial_name       varchar(250),
    ruc                  varchar(13),
    address_matriz       varchar(250),
    phone                varchar(100),
    email                varchar(250),
    special_taxpayer     varchar(5),
    accountant           char         default 'Y',
    email_user           varchar(250),
    email_password       varchar(250),
    email_port           varchar(5)   default 587,
    email_smtp           varchar(150) default 'smtp.gmail.com',
    email_security       bit,
    electronic_signature varchar(250),
    key_signature        varchar(250),
    logo                 varchar(250) default 'logo.png',
    start_date_signature datetime,
    end_date_signature   datetime,
    retention_agent      varchar(250),
    environment          int          default 1,
    status               char         default 'A'
)
    go

create table tbl_branch
(
    id_br         int identity
        constraint tbl_branch_pk
            primary key,
    code          varchar(250),
    description   varchar(250),
    id_enterprise int
        constraint tbl_branch_tbl_enterprise_id_en_fk
            references tbl_enterprise,
    address       varchar(250),
    phone         varchar(10),
    status        char     default 'A',
    created_at    datetime default getdate()
)
    go

create table tbl_category
(
    id_ca         int identity
        constraint tbl_category_pk
            primary key,
    name          varchar(250),
    status        char     default 'A',
    id_enterprise int
        constraint tbl_category_tbl_enterprise_id_en_fk
            references tbl_enterprise,
    description   varchar(max),
    created_at    datetime default getdate(),
    update_at     datetime default getdate()
)
    go

create table tbl_article
(
    id_ar         int identity
        constraint tbl_article_pk
            primary key,
    name          varchar(max),
    code          varchar(250),
    price_unit    decimal(10, 2),
    stock         int,
    status        char         default 'A',
    created_at    datetime     default getdate(),
    update_at     datetime     default getdate(),
    image         varchar(max) default 'no tiene',
    description   varchar(max),
    id_enterprise int
        constraint tbl_article_tbl_enterprise_id_en_fk
            references tbl_enterprise,
    id_category   int
        constraint tbl_article_tbl_category_id_ca_fk
            references tbl_category,
    type          char         default 'N',
    include_vat   char         default 'N'
)
    go

create table tbl_emission_point
(
    id_e_p     int identity
        constraint tbl_emission_point_pk
            primary key,
    code       varchar(250),
    [details ] text,
    type       bit,
    id_branch  int
        constraint tbl_emission_point_tbl_branch_id_br_fk
            references tbl_branch
)
    go

create table tbl_fare
(
    id_fare     int identity
        constraint tbl_fare_pk
            primary key,
    percentage  decimal(5, 2),
    description varchar(max),
    id_tax      int,
    code        varchar(2)
)
    go

create table tbl_credit_note_detail
(
    id_c_n_d       int identity
        constraint tbl_credit_note_detail_pk
            primary key,
    note_credit_id int,
    code_stub      nvarchar(50)                not null,
    description    nvarchar(255)               not null,
    amount         int                         not null,
    price_unit     decimal(10, 4)              not null,
    discount       decimal(10, 2) default 0.00 not null,
    neto           decimal(10, 2) default 0.00 not null,
    iva_porc       decimal(5, 2)  default 0.00 not null,
    ice_porc       decimal(5, 2)  default 0.00 not null,
    iva_valor      decimal(10, 2) default 0.00 not null,
    ice_valor      decimal(10, 2) default 0.00 not null,
    subtotal       decimal(10, 2) default 0.00 not null,
    total          decimal(10, 2) default 0.00 not null,
    nota1          nvarchar(255),
    nota2          nvarchar(255),
    nota3          nvarchar(255),
    id_tariff      int
        constraint tbl_credit_note_detail_tbl_fare_id_fare_fk
            references tbl_fare,
    id_article     int
        constraint tbl_credit_note_detail_tbl_article_id_ar_fk
            references tbl_article,
    created_at     datetime2      default getdate(),
    updated_at     datetime2      default getdate()
)
    go

create table tbl_payment
(
    id_payment int identity
        constraint tbl_payment_pk
            primary key,
    sri_detail text,
    detail     text,
    status     bit
)
    go

create table tbl_report
(
    id_re         int identity
        constraint tbl_report_pk
            primary key,
    action_re     varchar(250) not null,
    created_at_re datetime     default getdate(),
    user_re       varchar(250) default 'Josue Ulloa',
    dni_re        varchar(50)  default '1755386099',
    status_re     char         default 'A'
)
    go

create table tbl_rol
(
    id_rol     int identity
        constraint tbl_rol_pk
            primary key,
    name_rol   varchar(250) default 'User' not null,
    status_rol char         default 'A'
)
    go

create table tbl_sequence
(
    id_sequence       int identity
        constraint tbl_sequence_pk
            primary key,
    id_emission_point int
        constraint tbl_sequence_tbl_emission_point_id_e_p_fk
            references tbl_emission_point,
    id_document_type  int
        constraint tbl_sequence_tbl_document_type_id_d_t_fk
            references tbl_document_type,
    code              varchar(250)
)
    go

create table tbl_tariff_article
(
    id_t_a     int identity
        constraint tbl_tariff_article_pk
            primary key,
    id_fare    int
        constraint tbl_tariff_article_tbl_fare_id_fare_fk
            references tbl_fare,
    id_article int
        constraint tbl_tariff_article_tbl_article_id_ar_fk
            references tbl_article
)
    go

create table tbl_tax
(
    id_ta       int identity
        constraint tbl_tax_pk
            primary key,
    description varchar(100)
)
    go

create table tbl_type_dni
(
    id_t_d int identity
        constraint tbl_type_dni_pk
            primary key,
    name   varchar(100)
)
    go

create table tbl_client
(
    id_client    int identity
        constraint tbl_client_pk
            primary key,
    razon_social varchar(250),
    dni          varchar(13),
    address      varchar(250),
    phone        varchar(20),
    email        varchar(250),
    info         text,
    id_type_dni  int
        constraint tbl_client_tbl_type_dni_id_t_d_fk
            references tbl_type_dni,
    status       char default 'A'
)
    go

create table tbl_enterprise_client
(
    id_en_cl      int identity
        constraint tbl_enterprise_client_pk
            primary key,
    enterprise_id int              not null
        constraint tbl_enterprise_client_tbl_enterprise_id_en_fk
            references tbl_enterprise,
    client_id     int              not null
        constraint tbl_enterprise_client_tbl_client_id_client_fk
            references tbl_client,
    status        char default 'A' not null
)
    go

create table tbl_invoice
(
    inv_id               int identity
        constraint tbl_invoice_pk
            primary key,
    emission_date        datetime    default getdate(),
    total_without_taxes  decimal(18, 2),
    total_discount       decimal(18, 2),
    tip                  decimal(18, 2),
    total_amount         decimal(18, 2),
    currency             varchar(10),
    sequence_id          int
        constraint tbl_invoice_tbl_sequence_id_sequence_fk
            references tbl_sequence,
    electronic_status    varchar(50) default 'NO ENVIADO',
    invoice_status       varchar(50) default 'NO AUTORIZADO',
    id_emission_point    int
        constraint tbl_invoice_tbl_emission_point_id_e_p_fk
            references tbl_emission_point,
    company_id           int
        constraint tbl_invoice_tbl_enterprise_id_en_fk
            references tbl_enterprise,
    client_id            int
        constraint tbl_invoice_tbl_client_id_client_fk
            references tbl_client,
    access_key           varchar(250),
    branch_id            int
        constraint tbl_invoice_tbl_branch_id_br_fk
            references tbl_branch,
    receipt_id           int
        constraint tbl_invoice_tbl_document_type_id_d_t_fk
            references tbl_document_type,
    authorization_date   datetime,
    authorization_number varchar(50) default 'N/A',
    total_vat            decimal(18, 2),
    total_vat_0          decimal(18, 2),
    vat                  decimal(18, 2),
    message              varchar(max),
    additional_info      varchar(max),
    modified_doc_number  varchar(50),
    modified_doc_date    date,
    sequence             varchar(100),
    xml                  varchar(250),
    XmlBase64            varchar(max),
    pdfBase64            varchar(max)
)
    go

create table tbl_credit_note
(
    id_c_n                     int identity
        constraint tbl_credit_note_pk
            primary key,
    emission_date              datetime       default getdate(),
    total_without_taxes        decimal(10, 2) default 0.00         not null,
    total_discount             decimal(10, 2) default 0.00         not null,
    tip                        decimal(10, 2) default 0.00,
    total_amount               decimal(10, 2) default 0.00         not null,
    currency                   nvarchar(3)    default 'USD'        not null,
    cod_doc_modificado         nvarchar(2)    default '04'         not null,
    num_doc_modificado         nvarchar(50)                        not null,
    emission_date_doc_sustento datetime2                           not null,
    modification_value         decimal(10, 2) default 0            not null,
    motive                     nvarchar(300)                       not null,
    access_key                 nvarchar(50)                        not null,
    authorization_number       nvarchar(50)                        not null,
    authorization_date         datetime2,
    electronic_status          nvarchar(20)   default 'PENDIENTES' not null,
    aditional_info             nvarchar(300),
    message                    nvarchar(255),
    sequence                   nvarchar(100),
    xml                        nvarchar(255),
    sequence_id                int
        constraint tbl_credit_note_tbl_sequence_id_sequence_fk
            references tbl_sequence,
    id_emission_point          int
        constraint tbl_credit_note_tbl_emission_point_id_e_p_fk
            references tbl_emission_point,
    company_id                 int
        constraint tbl_credit_note_tbl_enterprise_id_en_fk
            references tbl_enterprise,
    client_id                  int
        constraint tbl_credit_note_tbl_client_id_client_fk
            references tbl_client,
    branch_id                  int
        constraint tbl_credit_note_tbl_branch_id_br_fk
            references tbl_branch,
    receipt_id                 int
        constraint tbl_credit_note_tbl_document_type_id_d_t_fk
            references tbl_document_type,
    invoice_original_id        int
        constraint tbl_credit_note_tbl_invoice_inv_id_fk
            references tbl_invoice,
    created_at                 datetime2      default getdate()    not null,
    updated_at                 datetime2      default getdate()    not null,
    created_by                 datetime2,
    updated_by                 datetime2,
    xml_base64                 nvarchar(max)
)
    go

create table tbl_invoice_detail
(
    id_i_d              int identity
        constraint tbl_invoice_detail_pk
            primary key,
    code_stub           varchar(250),
    description         text,
    amount              int,
    price_unit          decimal(10, 2),
    discount            decimal(10, 2),
    price_with_discount decimal(18, 2),
    neto                decimal(18, 2),
    iva_porc            decimal(5, 2),
    iva_valor           decimal(18, 2),
    ice_porc            decimal(5, 2),
    ice_valor           decimal(18, 2),
    irbp_valor          decimal(18, 2),
    subtotal            decimal(18, 2),
    total               decimal(18, 2),
    id_invoice          int
        constraint tbl_invoice_detail_tbl_invoice_inv_id_fk
            references tbl_invoice,
    note1               nvarchar(max),
    note2               nvarchar(max),
    note3               nvarchar(max),
    id_tariff           int
        constraint tbl_invoice_detail_tbl_fare_id_fare_fk
            references tbl_fare,
    id_article          int
        constraint tbl_invoice_detail_tbl_article_id_ar_fk
            references tbl_article
)
    go

create table tbl_invoice_payment
(
    id_i_p     int identity
        constraint tbl_invoice_payment_pk
            primary key,
    id_invoice int
        constraint tbl_invoice_payment_tbl_invoice_inv_id_fk
            references tbl_invoice,
    total      decimal(10, 2),
    deadline   int,
    unit_time  varchar(100),
    id_payment int
        constraint tbl_invoice_payment_tbl_payment_id_payment_fk
            references tbl_payment
)
    go

create table tbl_user
(
    id_us                int identity
        constraint tbl_user_pk
            primary key,
    name_us              varchar(250) not null,
    lastname_us          varchar(250) not null,
    email_us             varchar(250),
    password_us          varchar(250) not null,
    created_at           datetime     default getdate(),
    google_id            int,
    id_rol               int          default 1
        constraint tbl_user_tbl_rol_id_rol_fk
            references tbl_rol,
    dni_us               varchar(10)  default '1000000000',
    image_us             varchar(250),
    status_us            char         default 'I',
    birthday_us          datetime,
    fecha_arriendo_us    datetime     default getdate(),
    age_us               int,
    nationality_us       varchar(250) default 'ECUATORIANA',
    update_at            datetime     default getdate(),
    phone_us             varchar(10),
    terms_and_conditions char         default 'N',
    email_verified       char         default 'N',
    gender_us            varchar(250),
    is_web               bit
)
    go

create table tbl_enterprise_user
(
    id_e_u                     int identity
        constraint tbl_enterprise_user_pk
            primary key,
    id_user                    int
        constraint tbl_enterprise_user_tbl_user_id_us_fk
            references tbl_user,
    id_enterprise              int
        constraint tbl_enterprise_user_tbl_enterprise_id_en_fk
            references tbl_enterprise,
    status                     char default 'A',
    [start_date_subscription ] datetime,
    [end_date_subscription ]   datetime
)
    go

create table tbl_tokens
(
    id_token   int identity
        primary key,
    user_id    int           not null
        references tbl_user,
    token      nvarchar(max) not null,
    created_at datetime default getdate(),
    expires_at datetime      not null
)
    go

