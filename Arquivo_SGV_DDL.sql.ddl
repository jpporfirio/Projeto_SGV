-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-03-15 20:43:05 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE t_sgv_acesso CASCADE CONSTRAINTS;

DROP TABLE t_sgv_categoria_produto CASCADE CONSTRAINTS;

DROP TABLE t_sgv_classificacao_video CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cliente CASCADE CONSTRAINTS;

DROP TABLE t_sgv_fone_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_sgv_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_sgv_pessoa_fisica CASCADE CONSTRAINTS;

DROP TABLE t_sgv_pessoa_juridica CASCADE CONSTRAINTS;

DROP TABLE t_sgv_produto CASCADE CONSTRAINTS;

DROP TABLE t_sgv_sac CASCADE CONSTRAINTS;

DROP TABLE t_sgv_tipo_chamado CASCADE CONSTRAINTS;

DROP TABLE t_sgv_video CASCADE CONSTRAINTS;

DROP TABLE t_sgv_visualizacao CASCADE CONSTRAINTS;

DROP TABLE t_sgv_visualizacao_cliente CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_sgv_acesso (
    cd_cliente   NUMBER(10) NOT NULL,
    dt_hr_acesso DATE NOT NULL
);

ALTER TABLE t_sgv_acesso ADD CONSTRAINT pk_sgv_acesso PRIMARY KEY ( cd_cliente );

CREATE TABLE t_sgv_categoria_produto (
    cd_categoria NUMBER(10) NOT NULL,
    ds_categoria VARCHAR2(100) NOT NULL,
    st_categoria CHAR(1) NOT NULL,
    dt__inicio   DATE NOT NULL,
    dt_termino   DATE
);

ALTER TABLE t_sgv_categoria_produto
    ADD CONSTRAINT ck_sgv_st_cat_prod CHECK ( st_categoria IN ( 'A', 'I' ) );

ALTER TABLE t_sgv_categoria_produto ADD CONSTRAINT pk_sgv_cat_prod PRIMARY KEY ( cd_categoria );

ALTER TABLE t_sgv_categoria_produto ADD CONSTRAINT un_sgv_ds_cat_prod UNIQUE ( ds_categoria );

CREATE TABLE t_sgv_classificacao_video (
    cd_categoria     NUMBER(10) NOT NULL,
    ds_classificacao VARCHAR2(150) NOT NULL
);

ALTER TABLE t_sgv_classificacao_video ADD CONSTRAINT pk_sgv_class_vid PRIMARY KEY ( cd_categoria );

CREATE TABLE t_sgv_cliente (
    cd_cliente   NUMBER(10) NOT NULL,
    nm_cliente   VARCHAR2(200) NOT NULL,
    st_cliente   CHAR(1) NOT NULL,
    sg_tp_pessoa CHAR(1) NOT NULL,
    login        VARCHAR2(30) NOT NULL,
    senha        VARCHAR2(30) NOT NULL,
    estrelas     NUMBER(1),
    telefone     NUMBER(11)
);

ALTER TABLE t_sgv_cliente
    ADD CONSTRAINT ck_sgv_estrela_cl CHECK ( estrelas BETWEEN 1 AND 5 );

ALTER TABLE t_sgv_cliente
    ADD CONSTRAINT ck_sgv_st_cl CHECK ( st_cliente IN ( 'A', 'I' ) );

ALTER TABLE t_sgv_cliente
    ADD CONSTRAINT ck_sgv_tp_p CHECK ( sg_tp_pessoa IN ( 'F', 'J' ) );

ALTER TABLE t_sgv_cliente ADD CONSTRAINT pk_sgv_cl PRIMARY KEY ( cd_cliente );

CREATE TABLE t_sgv_fone_funcionario (
    nr_funcionario NUMBER(11) NOT NULL,
    cd_funcionario NUMBER NOT NULL
);

ALTER TABLE t_sgv_fone_funcionario ADD CONSTRAINT pk_sgv_fone_funci PRIMARY KEY ( nr_funcionario,
                                                                                  cd_funcionario );

CREATE TABLE t_sgv_funcionario (
    cd_funcionario NUMBER(10) NOT NULL,
    cpf            NUMBER(11) NOT NULL,
    nm_funcionario VARCHAR2(40) NOT NULL,
    departamento1  VARCHAR2(20) NOT NULL,
    dt_admissao    DATE NOT NULL,
    vl_salario     NUMBER(7, 2) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    ds_endereco    VARCHAR2(80) NOT NULL,
    cargo          VARCHAR2(20) NOT NULL,
    emaill         VARCHAR2(20)
);

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT pk_t_sgv_func PRIMARY KEY ( cd_funcionario );

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT un_sgv_cpf_func UNIQUE ( cpf );

CREATE TABLE t_sgv_pessoa_fisica (
    cd_cliente           NUMBER(10) NOT NULL,
    cpf                  NUMBER(11) NOT NULL,
    nome                 VARCHAR2(40) NOT NULL,
    sexo                 VARCHAR2(15) NOT NULL,
    dt_nascimento        DATE NOT NULL,
    ds_genero_nascimento VARCHAR2(20)
);

CREATE UNIQUE INDEX t_sgv_pessoa_fisica__idx ON
    t_sgv_pessoa_fisica (
        cd_cliente
    ASC );

ALTER TABLE t_sgv_pessoa_fisica ADD CONSTRAINT pk_sgv_pf PRIMARY KEY ( cpf,
                                                                       cd_cliente );

CREATE TABLE t_sgv_pessoa_juridica (
    cd_cliente         NUMBER(10) NOT NULL,
    nome               VARCHAR2(30) NOT NULL,
    cnpj               NUMBER(14),
    dt_fundacao        DATE,
    inscricao_estadual NUMBER(13)
);

COMMENT ON COLUMN t_sgv_pessoa_juridica.cd_cliente IS
    'tela
Parar de compa';

ALTER TABLE t_sgv_pessoa_juridica ADD CONSTRAINT pk_sgv_pj PRIMARY KEY ( cd_cliente );

CREATE TABLE t_sgv_produto (
    cd_produto          NUMBER(10) NOT NULL,
    cd_categoria        NUMBER(10) NOT NULL,
    ds_produto          VARCHAR2(100) NOT NULL,
    st_produto          CHAR(1) NOT NULL,
    ds_completo_produto VARCHAR2(200) NOT NULL,
    qt_produto          NUMBER(4) NOT NULL,
    vl_preco_unitario   NUMBER(7, 2) NOT NULL,
    cd_barras           NUMBER(13)
);

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT ck_sgv_st_produto CHECK ( st_produto IN ( 'A', 'I', 'P' ) );

ALTER TABLE t_sgv_produto ADD CONSTRAINT pk_sgv_prod PRIMARY KEY ( cd_produto );

ALTER TABLE t_sgv_produto ADD CONSTRAINT un_sgv_ds_prod UNIQUE ( ds_produto );

CREATE TABLE t_sgv_sac (
    cd_chamado        NUMBER(10) NOT NULL,
    cd_cliente        NUMBER NOT NULL,
    cd_produto        NUMBER(10) NOT NULL,
    cd_funcionario    NUMBER(10) NOT NULL,
    cd_tp_chamado     NUMBER(1) NOT NULL,
    st_chamado        CHAR(1) NOT NULL,
    dt_abertura       DATE NOT NULL,
    dt_hr_atendimento DATE,
    ds_chamado        VARCHAR2(4000),
    duracao_chamado   DATE,
    satisfacao        NUMBER(2)
);

ALTER TABLE t_sgv_sac
    ADD CONSTRAINT ck_sgv_sati_sac CHECK ( satisfacao BETWEEN '1' AND '10' );

ALTER TABLE t_sgv_sac
    ADD CONSTRAINT ck_sgv_st_sac CHECK ( st_chamado IN ( 'A', 'E', 'C', 'F', 'X' ) );

ALTER TABLE t_sgv_sac ADD CONSTRAINT pk_t_sgv_sac PRIMARY KEY ( cd_chamado );

CREATE TABLE t_sgv_tipo_chamado (
    cd_tp_chamado NUMBER(1) NOT NULL,
    ds_tp_chamado VARCHAR2(20) NOT NULL
);

ALTER TABLE t_sgv_tipo_chamado ADD CONSTRAINT pk_sgv_tp_cham PRIMARY KEY ( cd_tp_chamado );

CREATE TABLE t_sgv_video (
    cd_produto   NUMBER(10) NOT NULL,
    cd_video     NUMBER(10) NOT NULL,
    cd_categoria NUMBER(10) NOT NULL,
    nm_video     VARCHAR2(30) NOT NULL,
    st_video     CHAR(1) NOT NULL
);

ALTER TABLE t_sgv_video
    ADD CONSTRAINT ck_sgv_st_video CHECK ( st_video IN ( 'A', 'I' ) );

ALTER TABLE t_sgv_video ADD CONSTRAINT pk_t_sgv_video PRIMARY KEY ( cd_video,
                                                                    cd_produto );

CREATE TABLE t_sgv_visualizacao (
    cd_visualizacao    NUMBER(10) NOT NULL,
    cd_video           NUMBER(10) NOT NULL,
    cd_produto         NUMBER(10) NOT NULL,
    dt_hr_visualizacao DATE NOT NULL
);

ALTER TABLE t_sgv_visualizacao ADD CONSTRAINT pk_sgv_visu PRIMARY KEY ( cd_visualizacao );

CREATE TABLE t_sgv_visualizacao_cliente (
    cd_visualizacao         NUMBER(10) NOT NULL,
    cd_visualizacao_cliente NUMBER(10) NOT NULL,
    cd_cliente              NUMBER(10) NOT NULL,
    tempo_visualizacao      DATE NOT NULL,
    adicionou_no_carrinho   BLOB NOT NULL,
    comprou_o_produto       BLOB NOT NULL
);

ALTER TABLE t_sgv_visualizacao_cliente ADD CONSTRAINT pk_t_sgv_visu_cl PRIMARY KEY ( cd_visualizacao_cliente,
                                                                                     cd_visualizacao );

ALTER TABLE t_sgv_acesso
    ADD CONSTRAINT fk_sgv_acesso_cl FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_fone_funcionario
    ADD CONSTRAINT fk_sgv_fone_funci_funci FOREIGN KEY ( cd_funcionario )
        REFERENCES t_sgv_funcionario ( cd_funcionario );

ALTER TABLE t_sgv_pessoa_fisica
    ADD CONSTRAINT fk_sgv_pf_cl FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_pessoa_juridica
    ADD CONSTRAINT fk_sgv_pj_cl FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT fk_sgv_prod_cat_prod FOREIGN KEY ( cd_categoria )
        REFERENCES t_sgv_categoria_produto ( cd_categoria );

ALTER TABLE t_sgv_sac
    ADD CONSTRAINT fk_sgv_sac_cl FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_sac
    ADD CONSTRAINT fk_sgv_sac_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_sgv_funcionario ( cd_funcionario );

ALTER TABLE t_sgv_sac
    ADD CONSTRAINT fk_sgv_sac_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_sac
    ADD CONSTRAINT fk_sgv_sac_tp_cham FOREIGN KEY ( cd_tp_chamado )
        REFERENCES t_sgv_tipo_chamado ( cd_tp_chamado );

ALTER TABLE t_sgv_video
    ADD CONSTRAINT fk_sgv_vid_class_vid FOREIGN KEY ( cd_categoria )
        REFERENCES t_sgv_classificacao_video ( cd_categoria );

ALTER TABLE t_sgv_video
    ADD CONSTRAINT fk_sgv_vid_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_visualizacao_cliente
    ADD CONSTRAINT fk_sgv_visu_cl_cl FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_visualizacao_cliente
    ADD CONSTRAINT fk_sgv_visu_cl_visu FOREIGN KEY ( cd_visualizacao )
        REFERENCES t_sgv_visualizacao ( cd_visualizacao );

ALTER TABLE t_sgv_visualizacao
    ADD CONSTRAINT fk_sgv_visu_vid FOREIGN KEY ( cd_video,
                                                 cd_produto )
        REFERENCES t_sgv_video ( cd_video,
                                 cd_produto );

CREATE OR REPLACE TRIGGER arc_arc_5_t_sgv_pessoa_fisica BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_sgv_pessoa_fisica
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.sg_tp_pessoa
    INTO d
    FROM
        t_sgv_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 'F' ) THEN
        raise_application_error(-20223, 'FK FK_SGV_PF_CL in Table T_SGV_PESSOA_FISICA violates Arc constraint on Table T_SGV_CLIENTE - discriminator column sg_tp_pessoa doesn''t have value ''F'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc__t_sgv_pessoa_juridica BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_sgv_pessoa_juridica
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.sg_tp_pessoa
    INTO d
    FROM
        t_sgv_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 'J' ) THEN
        raise_application_error(-20223, 'FK FK_SGV_PJ_CL in Table T_SGV_PESSOA_JURIDICA violates Arc constraint on Table T_SGV_CLIENTE - discriminator column sg_tp_pessoa doesn''t have value ''J'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             1
-- ALTER TABLE                             39
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
