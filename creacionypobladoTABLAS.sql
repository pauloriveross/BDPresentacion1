-- Script unico: creacion y poblacion de tablas - Gimnasio (Taller Base de Datos)
-- Generado desde TABLAS.sql (modelo relacional actualizado) + datos coherentes
-- Geografia completa: 1 pais (Chile), 16 regiones, 56 ciudades, 346 comunas.
-- 50 registros en cada tabla de negocio; RUTs chilenos validos (digito verificador).
-- ============================================================
-- 1) REINICIO: elimina las tablas y sus datos para recargar todo
-- ============================================================
DROP TABLE AGENDA CASCADE CONSTRAINTS PURGE;
DROP TABLE BLOQUE_HORARIO CASCADE CONSTRAINTS PURGE;
DROP TABLE CAT_PATOLOGIA CASCADE CONSTRAINTS PURGE;
DROP TABLE CENTRO_DEP CASCADE CONSTRAINTS PURGE;
DROP TABLE CIUDAD CASCADE CONSTRAINTS PURGE;
DROP TABLE CLIENTE CASCADE CONSTRAINTS PURGE;
DROP TABLE COMUNA CASCADE CONSTRAINTS PURGE;
DROP TABLE CONTENER CASCADE CONSTRAINTS PURGE;
DROP TABLE CONTRATO_CLI CASCADE CONSTRAINTS PURGE;
DROP TABLE DEFINIR CASCADE CONSTRAINTS PURGE;
DROP TABLE DISENAR CASCADE CONSTRAINTS PURGE;
DROP TABLE EJERCICIO CASCADE CONSTRAINTS PURGE;
DROP TABLE EMPLEA CASCADE CONSTRAINTS PURGE;
DROP TABLE FACTURA CASCADE CONSTRAINTS PURGE;
DROP TABLE FICHA_CLIENTE CASCADE CONSTRAINTS PURGE;
DROP TABLE METODO_PAGO_CLI CASCADE CONSTRAINTS PURGE;
DROP TABLE METRICAS_CLIENTE CASCADE CONSTRAINTS PURGE;
DROP TABLE OFRECER CASCADE CONSTRAINTS PURGE;
DROP TABLE PAGO CASCADE CONSTRAINTS PURGE;
DROP TABLE PAIS CASCADE CONSTRAINTS PURGE;
DROP TABLE PATOLOGIAS CASCADE CONSTRAINTS PURGE;
DROP TABLE PLAN CASCADE CONSTRAINTS PURGE;
DROP TABLE PREPARADOR_FISICO CASCADE CONSTRAINTS PURGE;
DROP TABLE PROGRE_CLI CASCADE CONSTRAINTS PURGE;
DROP TABLE REGION CASCADE CONSTRAINTS PURGE;
DROP TABLE REGISTRAR CASCADE CONSTRAINTS PURGE;
DROP TABLE RUTINA CASCADE CONSTRAINTS PURGE;
DROP TABLE SESION_ENTRENAMIENTO CASCADE CONSTRAINTS PURGE;
DROP TABLE TENER CASCADE CONSTRAINTS PURGE;

-- ============================================================
-- 2) CREACION DE LAS TABLAS
-- ============================================================


CREATE TABLE AGENDA 
    ( 
     id_agendar                 NUMBER (7)  NOT NULL , 
     fecha_agendar              DATE  NOT NULL , 
     hora_agendar               INTERVAL DAY (9) TO SECOND (0)  NOT NULL , 
     estado_agendar             VARCHAR2 (15)  NOT NULL , 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     CLIENTE_rut_cliente        VARCHAR2 (13)  NOT NULL 
    ) 
;

ALTER TABLE AGENDA 
    ADD CONSTRAINT AGENDA_PK PRIMARY KEY ( id_agendar, fecha_agendar ) ;

CREATE TABLE BLOQUE_HORARIO 
    ( 
     id_bloque            NUMBER (7)  NOT NULL , 
     dia_bloque           VARCHAR2 (20)  NOT NULL , 
     hora_bloque          INTERVAL DAY (9) TO SECOND (0)  NOT NULL , 
     AGENDA_id_agendar    NUMBER (7) , 
     AGENDA_fecha_agendar DATE 
    ) 
;

ALTER TABLE BLOQUE_HORARIO 
    ADD CONSTRAINT BLOQUE_HORARIO_PK PRIMARY KEY ( id_bloque ) ;

CREATE TABLE CAT_PATOLOGIA 
    ( 
     id_cat           NUMBER (4)  NOT NULL , 
     nombre_categoria VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE CAT_PATOLOGIA 
    ADD CONSTRAINT CAT_PATOLOGIA_PK PRIMARY KEY ( id_cat ) ;

CREATE TABLE CENTRO_DEP 
    ( 
     id_centro        NUMBER (6)  NOT NULL , 
     nombre_centro    VARCHAR2 (100)  NOT NULL , 
     rut_centro       VARCHAR2 (13)  NOT NULL , 
     COMUNA_id_comuna NUMBER (3) , 
     dir_centro       VARCHAR2 (150)  NOT NULL 
    ) 
;

ALTER TABLE CENTRO_DEP 
    ADD CONSTRAINT CENTRO_DEPORTIVO_PK PRIMARY KEY ( id_centro ) ;

CREATE TABLE CIUDAD 
    ( 
     id_ciudad        NUMBER (3)  NOT NULL , 
     nombre_ciudad    VARCHAR2 (50)  NOT NULL , 
     REGION_id_region NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE CIUDAD 
    ADD CONSTRAINT CIUDAD_PK PRIMARY KEY ( id_ciudad ) ;

CREATE TABLE CLIENTE 
    ( 
     rut_cliente          VARCHAR2 (13)  NOT NULL , 
     pnombre_cliente      VARCHAR2 (150)  NOT NULL , 
     snombre_cliente      VARCHAR2 (150) , 
     papellido_cliente    VARCHAR2 (150)  NOT NULL , 
     sapellido_cliente    VARCHAR2 (150) , 
     fecha_nac_cliente    DATE  NOT NULL , 
     nacionalidad_cliente VARCHAR2 (150) , 
     PLAN_id_plan         NUMBER (7)  NOT NULL , 
     COMUNA_id_comuna     NUMBER (3) , 
     telefono_cliente     VARCHAR2 (9)  NOT NULL , 
     correo_cliente       VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_PK PRIMARY KEY ( rut_cliente ) ;

CREATE TABLE COMUNA 
    ( 
     id_comuna        NUMBER (3)  NOT NULL , 
     nombre_comuna    VARCHAR2 (50)  NOT NULL , 
     CIUDAD_id_ciudad NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( id_comuna ) ;

CREATE TABLE CONTENER 
    ( 
     RUTINA_id_rutina       NUMBER (7)  NOT NULL , 
     EJERCICIO_id_ejercicio NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE CONTENER 
    ADD CONSTRAINT CONTENER_PK PRIMARY KEY ( RUTINA_id_rutina, EJERCICIO_id_ejercicio ) ;

CREATE TABLE CONTRATO_CLI 
    ( 
     id_contrato            NUMBER (7)  NOT NULL , 
     fecha_inicio_contrato  DATE  NOT NULL , 
     fecha_termino_contrato DATE  NOT NULL , 
     estado_contrato        VARCHAR2 (30)  NOT NULL , 
     PLAN_id_plan           NUMBER (7)  NOT NULL , 
     fecha_ini              DATE , 
     fecha_ter              DATE 
    ) 
;

ALTER TABLE CONTRATO_CLI 
    ADD CONSTRAINT CONTRATO_CLI_PK PRIMARY KEY ( id_contrato ) ;

CREATE TABLE DEFINIR 
    ( 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     BLOQUE_HORARIO_id_bloque   NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE DEFINIR 
    ADD CONSTRAINT DEFINIR_PK PRIMARY KEY ( PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque ) ;

CREATE TABLE DISENAR 
    ( 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     RUTINA_id_rutina           NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE DISENAR 
    ADD CONSTRAINT DISENAR_PK PRIMARY KEY ( PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina ) ;

CREATE TABLE EJERCICIO 
    ( 
     id_ejercicio           NUMBER (7)  NOT NULL , 
     nombre_ejercicio       VARCHAR2 (50)  NOT NULL , 
     descripcion_ejercicio  VARCHAR2 (200)  NOT NULL , 
     repeticiones_ejercicio NUMBER (2)  NOT NULL , 
     peso_ejercicio         NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE EJERCICIO 
    ADD CONSTRAINT EJERCICIO_PK PRIMARY KEY ( id_ejercicio ) ;

CREATE TABLE EMPLEA 
    ( 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     CENTRO_DEPORTIVO_id_centro NUMBER (6)  NOT NULL 
    ) 
;

ALTER TABLE EMPLEA 
    ADD CONSTRAINT EMPLEA_PK PRIMARY KEY ( PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro ) ;

CREATE TABLE FACTURA 
    ( 
     id_factura    NUMBER (7)  NOT NULL , 
     fecha_emision DATE  NOT NULL , 
     total_factura NUMBER (6)  NOT NULL , 
     PAGO_id_pago  NUMBER (7)  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX FACTURA__IDX ON FACTURA 
    ( 
     PAGO_id_pago ASC 
    ) 
;

ALTER TABLE FACTURA 
    ADD CONSTRAINT FACTURA_PK PRIMARY KEY ( id_factura ) ;

CREATE TABLE FICHA_CLIENTE 
    ( 
     id_ficha          NUMBER (7)  NOT NULL , 
     fecha_creacion    DATE  NOT NULL , 
     observaciones     VARCHAR2 (200) , 
     fecha_observacion DATE  NOT NULL 
    ) 
;

ALTER TABLE FICHA_CLIENTE 
    ADD CONSTRAINT FICHA_CLIENTE_PK PRIMARY KEY ( id_ficha ) ;

CREATE TABLE METODO_PAGO_CLI 
    ( 
     id_metodo_pago          NUMBER (7)  NOT NULL , 
     nombre_metodo_pago      VARCHAR2 (50)  NOT NULL , 
     descripcion_metodo_pago VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE METODO_PAGO_CLI 
    ADD CONSTRAINT METODO_PAGO_CLI_PK PRIMARY KEY ( id_metodo_pago ) ;

CREATE TABLE METRICAS_CLIENTE 
    ( 
     id_metrica                  NUMBER (3)  NOT NULL , 
     peso_cliente                NUMBER (5,2)  NOT NULL , 
     estatura_cliente            NUMBER (5,2)  NOT NULL , 
     medida_pecho_cliente        NUMBER (5,2)  NOT NULL , 
     medida_cintura_cliente      NUMBER (5,2)  NOT NULL , 
     medida_cadera_cliente       NUMBER (5,2)  NOT NULL , 
     medida_hombros_cliente      NUMBER (5,2)  NOT NULL , 
     medida_brazos_cliente       NUMBER (5,2)  NOT NULL , 
     medida_muslos_cliente       NUMBER (5,2)  NOT NULL , 
     medidas_pantorillas_cliente NUMBER (5,2)  NOT NULL , 
     fecha_medicion_cliente      DATE  NOT NULL 
    ) 
;

ALTER TABLE METRICAS_CLIENTE 
    ADD CONSTRAINT METRICAS_CLIENTE_PK PRIMARY KEY ( id_metrica ) ;

CREATE TABLE OFRECER 
    ( 
     PREPARADOR_FISICO_rut_prep VARCHAR2 (13)  NOT NULL , 
     PLAN_id_plan               NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE OFRECER 
    ADD CONSTRAINT OFRECER_PK PRIMARY KEY ( PREPARADOR_FISICO_rut_prep, PLAN_id_plan ) ;

CREATE TABLE PAGO 
    ( 
     id_pago                        NUMBER (7)  NOT NULL , 
     monto_pago                     NUMBER (6)  NOT NULL , 
     fecha_pago                     DATE  NOT NULL , 
     estado_pago                    VARCHAR2 (30)  NOT NULL , 
     CONTRATO_CLI_id_contrato       NUMBER (7)  NOT NULL , 
     METODO_PAGO_CLI_id_metodo_pago NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_PK PRIMARY KEY ( id_pago ) ;

CREATE TABLE PAIS 
    ( 
     id_pais     NUMBER (3)  NOT NULL , 
     nombre_pais VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE PAIS 
    ADD CONSTRAINT PAIS_PK PRIMARY KEY ( id_pais ) ;

CREATE TABLE PATOLOGIAS 
    ( 
     id_patologia           NUMBER (3)  NOT NULL , 
     nombre_patologia       VARCHAR2 (150)  NOT NULL , 
     tipo_patologia         VARCHAR2 (150)  NOT NULL , 
     grado_patologia        VARCHAR2 (150)  NOT NULL , 
     duracion_patologia     VARCHAR2 (150)  NOT NULL , 
     FICHA_CLIENTE_id_ficha NUMBER (7) , 
     CAT_PATOLOGIA_id_cat   NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE PATOLOGIAS 
    ADD CONSTRAINT PATOLOGIAS_PK PRIMARY KEY ( id_patologia ) ;

CREATE TABLE PLAN 
    ( 
     id_plan          NUMBER (7)  NOT NULL , 
     nombre_plan      VARCHAR2 (50)  NOT NULL , 
     precio_plan      NUMBER (5)  NOT NULL , 
     duracion_plan    VARCHAR2 (50)  NOT NULL , 
     descripcion_plan VARCHAR2 (200)  NOT NULL 
    ) 
;

ALTER TABLE PLAN 
    ADD CONSTRAINT PLAN_PK PRIMARY KEY ( id_plan ) ;

CREATE TABLE PREPARADOR_FISICO 
    ( 
     rut_prep                VARCHAR2 (13)  NOT NULL , 
     pnombre_preparador      VARCHAR2 (150)  NOT NULL , 
     snombre_preparador      VARCHAR2 (150) , 
     papellido_preparador    VARCHAR2 (150)  NOT NULL , 
     sapellido_preparador    VARCHAR2 (150) , 
     fecha_nac_preparador    DATE  NOT NULL , 
     especialidad_preparador VARCHAR2 (150)  NOT NULL , 
     COMUNA_id_comuna        NUMBER (3) , 
     correo_preparador       VARCHAR2 (100)  NOT NULL , 
     telefono_preparador     VARCHAR2 (9)  NOT NULL 
    ) 
;

ALTER TABLE PREPARADOR_FISICO 
    ADD CONSTRAINT PREPARADOR_FISICO_PK PRIMARY KEY ( rut_prep ) ;

CREATE TABLE PROGRE_CLI 
    ( 
     id_progreso            NUMBER (7)  NOT NULL , 
     descripcion_progreso   VARCHAR2 (200)  NOT NULL , 
     fecha_progreso         DATE  NOT NULL , 
     FICHA_CLIENTE_id_ficha NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE PROGRE_CLI 
    ADD CONSTRAINT PROGRE_CLI_PK PRIMARY KEY ( id_progreso ) ;

CREATE TABLE REGION 
    ( 
     id_region     NUMBER (3)  NOT NULL , 
     nombre_region VARCHAR2 (50)  NOT NULL , 
     PAIS_id_pais  NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PK PRIMARY KEY ( id_region ) ;

CREATE TABLE REGISTRAR 
    ( 
     METRICAS_CLIENTE_id_metrica NUMBER (3)  NOT NULL , 
     FICHA_CLIENTE_id_ficha      NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE REGISTRAR 
    ADD CONSTRAINT REGISTRAR_PK PRIMARY KEY ( METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha ) ;

CREATE TABLE RUTINA 
    ( 
     id_rutina           NUMBER (7)  NOT NULL , 
     nombre_rutina       VARCHAR2 (50)  NOT NULL , 
     CLIENTE_rut_cliente VARCHAR2 (13) 
    ) 
;

ALTER TABLE RUTINA 
    ADD CONSTRAINT RUTINA_PK PRIMARY KEY ( id_rutina ) ;

CREATE TABLE SESION_ENTRENAMIENTO 
    ( 
     id_sesion            NUMBER (7)  NOT NULL , 
     fecha_sesion         DATE  NOT NULL , 
     duracion_sesion      INTERVAL DAY (9) TO SECOND (0)  NOT NULL , 
     RUTINA_id_rutina     NUMBER (7) , 
     AGENDA_id_agendar    NUMBER (7) , 
     AGENDA_fecha_agendar DATE 
    ) 
;

ALTER TABLE SESION_ENTRENAMIENTO 
    ADD CONSTRAINT SESION_ENTRENAMIENTO_PK PRIMARY KEY ( id_sesion ) ;

CREATE TABLE TENER 
    ( 
     CLIENTE_rut_cliente    VARCHAR2 (13)  NOT NULL , 
     FICHA_CLIENTE_id_ficha NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE TENER 
    ADD CONSTRAINT TENER_PK PRIMARY KEY ( CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha ) ;

ALTER TABLE AGENDA 
    ADD CONSTRAINT AGENDA_CLIENTE_FK FOREIGN KEY 
    ( 
     CLIENTE_rut_cliente
    ) 
    REFERENCES CLIENTE 
    ( 
     rut_cliente
    ) 
;

ALTER TABLE AGENDA 
    ADD CONSTRAINT AGENDA_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE BLOQUE_HORARIO 
    ADD CONSTRAINT BLOQUE_HORARIO_AGENDA_FK FOREIGN KEY 
    ( 
     AGENDA_id_agendar,
     AGENDA_fecha_agendar
    ) 
    REFERENCES AGENDA 
    ( 
     id_agendar,
     fecha_agendar
    ) 
;

ALTER TABLE CENTRO_DEP 
    ADD CONSTRAINT CENTRO_DEP_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE CIUDAD 
    ADD CONSTRAINT CIUDAD_REGION_FK FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_PLAN_FK FOREIGN KEY 
    ( 
     PLAN_id_plan
    ) 
    REFERENCES PLAN 
    ( 
     id_plan
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_CIUDAD_FK FOREIGN KEY 
    ( 
     CIUDAD_id_ciudad
    ) 
    REFERENCES CIUDAD 
    ( 
     id_ciudad
    ) 
;

ALTER TABLE CONTENER 
    ADD CONSTRAINT CONTENER_EJERCICIO_FK FOREIGN KEY 
    ( 
     EJERCICIO_id_ejercicio
    ) 
    REFERENCES EJERCICIO 
    ( 
     id_ejercicio
    ) 
;

ALTER TABLE CONTENER 
    ADD CONSTRAINT CONTENER_RUTINA_FK FOREIGN KEY 
    ( 
     RUTINA_id_rutina
    ) 
    REFERENCES RUTINA 
    ( 
     id_rutina
    ) 
;

ALTER TABLE CONTRATO_CLI 
    ADD CONSTRAINT CONTRATO_CLI_PLAN_FK FOREIGN KEY 
    ( 
     PLAN_id_plan
    ) 
    REFERENCES PLAN 
    ( 
     id_plan
    ) 
;

ALTER TABLE DEFINIR 
    ADD CONSTRAINT DEFINIR_BLOQUE_HORARIO_FK FOREIGN KEY 
    ( 
     BLOQUE_HORARIO_id_bloque
    ) 
    REFERENCES BLOQUE_HORARIO 
    ( 
     id_bloque
    ) 
;

ALTER TABLE DEFINIR 
    ADD CONSTRAINT DEFINIR_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE DISENAR 
    ADD CONSTRAINT DISENAR_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE DISENAR 
    ADD CONSTRAINT DISENAR_RUTINA_FK FOREIGN KEY 
    ( 
     RUTINA_id_rutina
    ) 
    REFERENCES RUTINA 
    ( 
     id_rutina
    ) 
;

ALTER TABLE EMPLEA 
    ADD CONSTRAINT EMPLEA_CENTRO_DEPORTIVO_FK FOREIGN KEY 
    ( 
     CENTRO_DEPORTIVO_id_centro
    ) 
    REFERENCES CENTRO_DEP 
    ( 
     id_centro
    ) 
;

ALTER TABLE EMPLEA 
    ADD CONSTRAINT EMPLEA_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE FACTURA 
    ADD CONSTRAINT FACTURA_PAGO_FK FOREIGN KEY 
    ( 
     PAGO_id_pago
    ) 
    REFERENCES PAGO 
    ( 
     id_pago
    ) 
;

ALTER TABLE OFRECER 
    ADD CONSTRAINT OFRECER_PLAN_FK FOREIGN KEY 
    ( 
     PLAN_id_plan
    ) 
    REFERENCES PLAN 
    ( 
     id_plan
    ) 
;

ALTER TABLE OFRECER 
    ADD CONSTRAINT OFRECER_PREPARADOR_FISICO_FK FOREIGN KEY 
    ( 
     PREPARADOR_FISICO_rut_prep
    ) 
    REFERENCES PREPARADOR_FISICO 
    ( 
     rut_prep
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_CONTRATO_CLI_FK FOREIGN KEY 
    ( 
     CONTRATO_CLI_id_contrato
    ) 
    REFERENCES CONTRATO_CLI 
    ( 
     id_contrato
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_METODO_PAGO_CLI_FK FOREIGN KEY 
    ( 
     METODO_PAGO_CLI_id_metodo_pago
    ) 
    REFERENCES METODO_PAGO_CLI 
    ( 
     id_metodo_pago
    ) 
;

ALTER TABLE PATOLOGIAS 
    ADD CONSTRAINT PATOLOGIAS_CAT_PATOLOGIA_FK FOREIGN KEY 
    ( 
     CAT_PATOLOGIA_id_cat
    ) 
    REFERENCES CAT_PATOLOGIA 
    ( 
     id_cat
    ) 
;

ALTER TABLE PATOLOGIAS 
    ADD CONSTRAINT PATOLOGIAS_FICHA_CLIENTE_FK FOREIGN KEY 
    ( 
     FICHA_CLIENTE_id_ficha
    ) 
    REFERENCES FICHA_CLIENTE 
    ( 
     id_ficha
    ) 
;

ALTER TABLE PREPARADOR_FISICO 
    ADD CONSTRAINT PREPARADOR_FISICO_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE PROGRE_CLI 
    ADD CONSTRAINT PROGRE_CLI_FICHA_CLIENTE_FK FOREIGN KEY 
    ( 
     FICHA_CLIENTE_id_ficha
    ) 
    REFERENCES FICHA_CLIENTE 
    ( 
     id_ficha
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PAIS_FK FOREIGN KEY 
    ( 
     PAIS_id_pais
    ) 
    REFERENCES PAIS 
    ( 
     id_pais
    ) 
;

ALTER TABLE REGISTRAR 
    ADD CONSTRAINT REGISTRAR_FICHA_CLIENTE_FK FOREIGN KEY 
    ( 
     FICHA_CLIENTE_id_ficha
    ) 
    REFERENCES FICHA_CLIENTE 
    ( 
     id_ficha
    ) 
;

ALTER TABLE REGISTRAR 
    ADD CONSTRAINT REGISTRAR_METRICAS_CLIENTE_FK FOREIGN KEY 
    ( 
     METRICAS_CLIENTE_id_metrica
    ) 
    REFERENCES METRICAS_CLIENTE 
    ( 
     id_metrica
    ) 
;

ALTER TABLE RUTINA 
    ADD CONSTRAINT RUTINA_CLIENTE_FK FOREIGN KEY 
    ( 
     CLIENTE_rut_cliente
    ) 
    REFERENCES CLIENTE 
    ( 
     rut_cliente
    ) 
;

ALTER TABLE SESION_ENTRENAMIENTO 
    ADD CONSTRAINT SESION_ENTRENAMIENTO_AGENDA_FK FOREIGN KEY 
    ( 
     AGENDA_id_agendar,
     AGENDA_fecha_agendar
    ) 
    REFERENCES AGENDA 
    ( 
     id_agendar,
     fecha_agendar
    ) 
;

ALTER TABLE SESION_ENTRENAMIENTO 
    ADD CONSTRAINT SESION_ENTRENAMIENTO_RUTINA_FK FOREIGN KEY 
    ( 
     RUTINA_id_rutina
    ) 
    REFERENCES RUTINA 
    ( 
     id_rutina
    ) 
;

ALTER TABLE TENER 
    ADD CONSTRAINT TENER_CLIENTE_FK FOREIGN KEY 
    ( 
     CLIENTE_rut_cliente
    ) 
    REFERENCES CLIENTE 
    ( 
     rut_cliente
    ) 
;

ALTER TABLE TENER 
    ADD CONSTRAINT TENER_FICHA_CLIENTE_FK FOREIGN KEY 
    ( 
     FICHA_CLIENTE_id_ficha
    ) 
    REFERENCES FICHA_CLIENTE 
    ( 
     id_ficha
    ) 
;

-- ============================================================
-- 3) POBLADO DE LAS TABLAS
-- ============================================================

-- PAIS: 1 registros
INSERT INTO PAIS (id_pais, nombre_pais) VALUES (1, 'Chile');

-- REGION: 16 registros
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (15, 'Arica y Parinacota', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (1, 'Tarapacá', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (2, 'Antofagasta', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (3, 'Atacama', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (4, 'Coquimbo', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (5, 'Valparaíso', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (13, 'Metropolitana de Santiago', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (6, 'Libertador General Bernardo O''Higgins', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (7, 'Maule', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (16, 'Ñuble', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (8, 'Biobío', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (9, 'La Araucanía', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (14, 'Los Ríos', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (10, 'Los Lagos', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (11, 'Aysén del General Carlos Ibáñez del Campo', 1);
INSERT INTO REGION (id_region, nombre_region, PAIS_id_pais) VALUES (12, 'Magallanes y de la Antártica Chilena', 1);

-- CIUDAD: 56 registros
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (1, 'Arica', 15);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (2, 'Putre', 15);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (3, 'Iquique', 1);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (4, 'Pozo Almonte', 1);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (5, 'Antofagasta', 2);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (6, 'Calama', 2);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (7, 'Tocopilla', 2);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (8, 'Copiapó', 3);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (9, 'Chañaral', 3);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (10, 'Vallenar', 3);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (11, 'La Serena', 4);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (12, 'Illapel', 4);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (13, 'Ovalle', 4);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (14, 'Valparaíso', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (15, 'Hanga Roa', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (16, 'Los Andes', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (17, 'La Ligua', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (18, 'Quillota', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (19, 'San Antonio', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (20, 'San Felipe', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (21, 'Quilpué', 5);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (22, 'Santiago', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (23, 'Puente Alto', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (24, 'Colina', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (25, 'San Bernardo', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (26, 'Melipilla', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (27, 'Talagante', 13);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (28, 'Rancagua', 6);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (29, 'Pichilemu', 6);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (30, 'San Fernando', 6);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (31, 'Curicó', 7);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (32, 'Talca', 7);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (33, 'Linares', 7);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (34, 'Cauquenes', 7);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (35, 'Chillán', 16);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (36, 'Quirihue', 16);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (37, 'San Carlos', 16);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (38, 'Concepción', 8);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (39, 'Lebu', 8);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (40, 'Los Ángeles', 8);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (41, 'Temuco', 9);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (42, 'Angol', 9);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (43, 'Valdivia', 14);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (44, 'La Unión', 14);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (45, 'Puerto Montt', 10);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (46, 'Osorno', 10);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (47, 'Castro', 10);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (48, 'Chaitén', 10);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (49, 'Coyhaique', 11);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (50, 'Puerto Aysén', 11);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (51, 'Cochrane', 11);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (52, 'Chile Chico', 11);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (53, 'Punta Arenas', 12);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (54, 'Puerto Natales', 12);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (55, 'Porvenir', 12);
INSERT INTO CIUDAD (id_ciudad, nombre_ciudad, REGION_id_region) VALUES (56, 'Puerto Williams', 12);

-- COMUNA: 346 registros
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (1, 'Arica', 1);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (2, 'Camarones', 1);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (3, 'General Lagos', 2);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (4, 'Putre', 2);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (5, 'Alto Hospicio', 3);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (6, 'Iquique', 3);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (7, 'Camiña', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (8, 'Colchane', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (9, 'Huara', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (10, 'Pica', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (11, 'Pozo Almonte', 4);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (12, 'Antofagasta', 5);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (13, 'Mejillones', 5);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (14, 'Sierra Gorda', 5);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (15, 'Taltal', 5);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (16, 'Calama', 6);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (17, 'Ollagüe', 6);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (18, 'San Pedro de Atacama', 6);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (19, 'María Elena', 7);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (20, 'Tocopilla', 7);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (21, 'Caldera', 8);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (22, 'Copiapó', 8);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (23, 'Tierra Amarilla', 8);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (24, 'Chañaral', 9);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (25, 'Diego de Almagro', 9);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (26, 'Alto del Carmen', 10);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (27, 'Freirina', 10);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (28, 'Huasco', 10);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (29, 'Vallenar', 10);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (30, 'Andacollo', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (31, 'Coquimbo', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (32, 'La Higuera', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (33, 'La Serena', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (34, 'Paiguano', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (35, 'Vicuña', 11);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (36, 'Canela', 12);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (37, 'Illapel', 12);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (38, 'Los Vilos', 12);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (39, 'Salamanca', 12);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (40, 'Combarbalá', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (41, 'Monte Patria', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (42, 'Ovalle', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (43, 'Punitaqui', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (44, 'Río Hurtado', 13);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (45, 'Casablanca', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (46, 'Concón', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (47, 'Juan Fernández', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (48, 'Puchuncaví', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (49, 'Quintero', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (50, 'Valparaíso', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (51, 'Viña del Mar', 14);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (52, 'Isla de Pascua', 15);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (53, 'Calle Larga', 16);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (54, 'Los Andes', 16);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (55, 'Rinconada', 16);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (56, 'San Esteban', 16);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (57, 'Cabildo', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (58, 'La Ligua', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (59, 'Papudo', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (60, 'Petorca', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (61, 'Zapallar', 17);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (62, 'Calera', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (63, 'Hijuelas', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (64, 'La Cruz', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (65, 'Nogales', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (66, 'Quillota', 18);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (67, 'Algarrobo', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (68, 'Cartagena', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (69, 'El Quisco', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (70, 'El Tabo', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (71, 'San Antonio', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (72, 'Santo Domingo', 19);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (73, 'Catemu', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (74, 'Llaillay', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (75, 'Panquehue', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (76, 'Putaendo', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (77, 'San Felipe', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (78, 'Santa María', 20);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (79, 'Limache', 21);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (80, 'Olmué', 21);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (81, 'Quilpué', 21);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (82, 'Villa Alemana', 21);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (83, 'Cerrillos', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (84, 'Cerro Navia', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (85, 'Conchalí', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (86, 'El Bosque', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (87, 'Estación Central', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (88, 'Huechuraba', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (89, 'Independencia', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (90, 'La Cisterna', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (91, 'La Florida', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (92, 'La Granja', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (93, 'La Pintana', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (94, 'La Reina', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (95, 'Las Condes', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (96, 'Lo Barnechea', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (97, 'Lo Espejo', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (98, 'Lo Prado', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (99, 'Macul', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (100, 'Maipú', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (101, 'Ñuñoa', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (102, 'Pedro Aguirre Cerda', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (103, 'Peñalolén', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (104, 'Providencia', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (105, 'Pudahuel', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (106, 'Quilicura', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (107, 'Quinta Normal', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (108, 'Recoleta', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (109, 'Renca', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (110, 'San Joaquín', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (111, 'San Miguel', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (112, 'San Ramón', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (113, 'Santiago', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (114, 'Vitacura', 22);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (115, 'Pirque', 23);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (116, 'Puente Alto', 23);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (117, 'San José de Maipo', 23);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (118, 'Colina', 24);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (119, 'Lampa', 24);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (120, 'Tiltil', 24);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (121, 'Buin', 25);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (122, 'Calera de Tango', 25);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (123, 'Paine', 25);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (124, 'San Bernardo', 25);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (125, 'Alhué', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (126, 'Curacaví', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (127, 'María Pinto', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (128, 'Melipilla', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (129, 'San Pedro', 26);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (130, 'El Monte', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (131, 'Isla de Maipo', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (132, 'Padre Hurtado', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (133, 'Peñaflor', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (134, 'Talagante', 27);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (135, 'Codegua', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (136, 'Coínco', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (137, 'Coltauco', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (138, 'Doñihue', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (139, 'Graneros', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (140, 'Las Cabras', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (141, 'Machalí', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (142, 'Malloa', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (143, 'Mostazal', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (144, 'Olivar', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (145, 'Peumo', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (146, 'Pichidegua', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (147, 'Quinta de Tilcoco', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (148, 'Rancagua', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (149, 'Rengo', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (150, 'Requínoa', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (151, 'San Vicente', 28);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (152, 'La Estrella', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (153, 'Litueche', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (154, 'Marchihue', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (155, 'Navidad', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (156, 'Paredones', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (157, 'Pichilemu', 29);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (158, 'Chépica', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (159, 'Chimbarongo', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (160, 'Lolol', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (161, 'Nancagua', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (162, 'Palmilla', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (163, 'Peralillo', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (164, 'Placilla', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (165, 'Pumanque', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (166, 'San Fernando', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (167, 'Santa Cruz', 30);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (168, 'Curicó', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (169, 'Hualañé', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (170, 'Licantén', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (171, 'Molina', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (172, 'Rauco', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (173, 'Romeral', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (174, 'Sagrada Familia', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (175, 'Teno', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (176, 'Vichuquén', 31);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (177, 'Constitución', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (178, 'Curepto', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (179, 'Empedrado', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (180, 'Maule', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (181, 'Pelarco', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (182, 'Pencahue', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (183, 'Río Claro', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (184, 'San Clemente', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (185, 'San Rafael', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (186, 'Talca', 32);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (187, 'Colbún', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (188, 'Linares', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (189, 'Longaví', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (190, 'Parral', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (191, 'Retiro', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (192, 'San Javier', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (193, 'Villa Alegre', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (194, 'Yerbas Buenas', 33);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (195, 'Cauquenes', 34);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (196, 'Chanco', 34);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (197, 'Pelluhue', 34);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (198, 'Bulnes', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (199, 'Chillán', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (200, 'Chillán Viejo', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (201, 'El Carmen', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (202, 'Pemuco', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (203, 'Pinto', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (204, 'Quillón', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (205, 'San Ignacio', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (206, 'Yungay', 35);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (207, 'Cobquecura', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (208, 'Coelemu', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (209, 'Ninhue', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (210, 'Portezuelo', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (211, 'Quirihue', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (212, 'Ránquil', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (213, 'Treguaco', 36);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (214, 'Coihueco', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (215, 'Ñiquén', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (216, 'San Carlos', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (217, 'San Fabián', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (218, 'San Nicolás', 37);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (219, 'Chiguayante', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (220, 'Concepción', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (221, 'Coronel', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (222, 'Florida', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (223, 'Hualpén', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (224, 'Hualqui', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (225, 'Lota', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (226, 'Penco', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (227, 'San Pedro de la Paz', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (228, 'Santa Juana', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (229, 'Talcahuano', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (230, 'Tomé', 38);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (231, 'Arauco', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (232, 'Cañete', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (233, 'Contulmo', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (234, 'Curanilahue', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (235, 'Lebu', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (236, 'Los Álamos', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (237, 'Tirúa', 39);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (238, 'Alto Biobío', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (239, 'Antuco', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (240, 'Cabrero', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (241, 'Laja', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (242, 'Los Ángeles', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (243, 'Mulchén', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (244, 'Nacimiento', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (245, 'Negrete', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (246, 'Quilaco', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (247, 'Quilleco', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (248, 'San Rosendo', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (249, 'Santa Bárbara', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (250, 'Tucapel', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (251, 'Yumbel', 40);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (252, 'Carahue', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (253, 'Cholchol', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (254, 'Cunco', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (255, 'Curarrehue', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (256, 'Freire', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (257, 'Galvarino', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (258, 'Gorbea', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (259, 'Lautaro', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (260, 'Loncoche', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (261, 'Melipeuco', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (262, 'Nueva Imperial', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (263, 'Padre Las Casas', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (264, 'Perquenco', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (265, 'Pitrufquén', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (266, 'Pucón', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (267, 'Saavedra', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (268, 'Temuco', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (269, 'Teodoro Schmidt', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (270, 'Toltén', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (271, 'Vilcún', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (272, 'Villarrica', 41);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (273, 'Angol', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (274, 'Collipulli', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (275, 'Curacautín', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (276, 'Ercilla', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (277, 'Lonquimay', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (278, 'Los Sauces', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (279, 'Lumaco', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (280, 'Purén', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (281, 'Renaico', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (282, 'Traiguén', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (283, 'Victoria', 42);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (284, 'Corral', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (285, 'Lanco', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (286, 'Los Lagos', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (287, 'Máfil', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (288, 'Mariquina', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (289, 'Paillaco', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (290, 'Panguipulli', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (291, 'Valdivia', 43);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (292, 'Futrono', 44);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (293, 'La Unión', 44);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (294, 'Lago Ranco', 44);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (295, 'Río Bueno', 44);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (296, 'Calbuco', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (297, 'Cochamó', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (298, 'Fresia', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (299, 'Frutillar', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (300, 'Llanquihue', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (301, 'Los Muermos', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (302, 'Maullín', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (303, 'Puerto Montt', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (304, 'Puerto Octay', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (305, 'Puerto Varas', 45);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (306, 'Osorno', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (307, 'Puyehue', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (308, 'Río Negro', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (309, 'San Juan de la Costa', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (310, 'San Pablo', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (311, 'Purranque', 46);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (312, 'Ancud', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (313, 'Castro', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (314, 'Chonchi', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (315, 'Curaco de Vélez', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (316, 'Dalcahue', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (317, 'Puqueldón', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (318, 'Queilén', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (319, 'Quellón', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (320, 'Quemchi', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (321, 'Quinchao', 47);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (322, 'Chaitén', 48);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (323, 'Futaleufú', 48);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (324, 'Hualaihué', 48);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (325, 'Palena', 48);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (326, 'Coyhaique', 49);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (327, 'Lago Verde', 49);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (328, 'Aysén', 50);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (329, 'Cisnes', 50);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (330, 'Guaitecas', 50);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (331, 'Cochrane', 51);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (332, 'O''Higgins', 51);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (333, 'Tortel', 51);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (334, 'Chile Chico', 52);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (335, 'Río Ibáñez', 52);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (336, 'Laguna Blanca', 53);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (337, 'Punta Arenas', 53);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (338, 'Río Verde', 53);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (339, 'San Gregorio', 53);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (340, 'Natales', 54);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (341, 'Torres del Paine', 54);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (342, 'Porvenir', 55);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (343, 'Primavera', 55);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (344, 'Timaukel', 55);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (345, 'Antártica', 56);
INSERT INTO COMUNA (id_comuna, nombre_comuna, CIUDAD_id_ciudad) VALUES (346, 'Cabo de Hornos', 56);

-- PREPARADOR_FISICO: 50 registros
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('23.507.938-0', 'Ignacio', 'José', 'López', 'Morales', TO_DATE('1981-03-16','YYYY-MM-DD'), 'Musculación y Fuerza', 14, 'ignacio.lopez501@gmail.com', '994290960');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.314.012-8', 'Camila', 'Alejandra', 'Salazar', 'Álvarez', TO_DATE('1988-03-03','YYYY-MM-DD'), 'Entrenamiento Funcional', 27, 'camila.salazar502@gmail.com', '915034008');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('22.515.298-5', 'Vicente', 'Alejandro', 'Cortés', 'Araya', TO_DATE('1990-12-04','YYYY-MM-DD'), 'CrossFit', 40, 'vicente.cortes503@gmail.com', '928516756');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.616.569-1', 'Camila', 'Antonia', 'Carrasco', 'Valenzuela', TO_DATE('1969-07-13','YYYY-MM-DD'), 'Nutrición Deportiva', 53, 'camila.carrasco504@gmail.com', '986857008');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('20.699.123-2', 'Pedro', 'Andrés', 'Vega', 'Contreras', TO_DATE('1972-12-13','YYYY-MM-DD'), 'Fisioterapia Deportiva', 66, 'pedro.vega505@gmail.com', '921480544');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('11.280.435-8', 'Constanza', 'Paz', 'Valenzuela', 'Rojas', TO_DATE('1989-04-06','YYYY-MM-DD'), 'Yoga y Movilidad', 79, 'constanza.valenzuela506@gmail.com', '989553785');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('22.131.805-6', 'Iván', 'José', 'Espinoza', 'Cortés', TO_DATE('1979-03-13','YYYY-MM-DD'), 'Cardio y Resistencia', 92, 'ivan.espinoza507@gmail.com', '948329736');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('15.710.873-5', 'Trinidad', NULL, 'Miranda', 'Fernández', TO_DATE('1979-09-06','YYYY-MM-DD'), 'Hipertrofia', 105, 'trinidad.miranda508@gmail.com', '966727512');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('11.504.328-5', 'Javier', NULL, 'Rodríguez', 'Castillo', TO_DATE('1972-03-01','YYYY-MM-DD'), 'Acondicionamiento Físico', 118, 'javier.rodriguez509@gmail.com', '982356296');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.352.468-0', 'Martina', NULL, 'Gutiérrez', 'Pérez', TO_DATE('1977-04-18','YYYY-MM-DD'), 'Rehabilitación', 131, 'martina.gutierrez510@gmail.com', '959391658');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.027.228-1', 'Nicolás', 'Antonio', 'Martínez', 'Contreras', TO_DATE('1983-02-28','YYYY-MM-DD'), 'Musculación y Fuerza', 144, 'nicolas.martinez511@gmail.com', '953794068');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('14.900.991-4', 'Claudia', 'Ignacia', 'Castro', 'Araya', TO_DATE('1977-11-04','YYYY-MM-DD'), 'Entrenamiento Funcional', 157, 'claudia.castro512@gmail.com', '992806254');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('14.825.159-2', 'Benjamín', 'Luis', 'Ortiz', 'Silva', TO_DATE('1984-04-27','YYYY-MM-DD'), 'CrossFit', 170, 'benjamin.ortiz513@gmail.com', '984570424');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.674.700-5', 'Javiera', 'Constanza', 'Carrasco', 'Reyes', TO_DATE('1970-02-26','YYYY-MM-DD'), 'Nutrición Deportiva', 183, 'javiera.carrasco514@gmail.com', '921079602');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('12.363.714-3', 'Ignacio', 'José', 'Araya', 'Hernández', TO_DATE('1978-07-17','YYYY-MM-DD'), 'Fisioterapia Deportiva', 196, 'ignacio.araya515@gmail.com', '932594416');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.704.807-3', 'Paz', 'Alejandra', 'Castillo', 'Ortiz', TO_DATE('1978-03-07','YYYY-MM-DD'), 'Yoga y Movilidad', 209, 'paz.castillo516@gmail.com', '964099053');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('20.817.865-2', 'Arturo', 'Luis', 'Hernández', 'Reyes', TO_DATE('1981-10-13','YYYY-MM-DD'), 'Cardio y Resistencia', 222, 'arturo.hernandez517@gmail.com', '956990221');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('21.810.749-4', 'Trinidad', 'Andrea', 'Tapia', 'Navarro', TO_DATE('1991-03-14','YYYY-MM-DD'), 'Hipertrofia', 235, 'trinidad.tapia518@gmail.com', '998159747');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('22.019.455-8', 'Joaquín', 'Alejandro', 'Silva', 'Castillo', TO_DATE('1994-08-09','YYYY-MM-DD'), 'Acondicionamiento Físico', 248, 'joaquin.silva519@gmail.com', '945763098');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.687.556-5', 'Josefa', 'Paz', 'Hernández', 'Ramírez', TO_DATE('1985-02-09','YYYY-MM-DD'), 'Rehabilitación', 261, 'josefa.hernandez520@gmail.com', '929255527');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('15.184.138-4', 'Vicente', 'Luis', 'Vargas', 'González', TO_DATE('1990-06-22','YYYY-MM-DD'), 'Musculación y Fuerza', 274, 'vicente.vargas521@gmail.com', '983784068');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('10.415.056-K', 'Rocío', 'Alejandra', 'Contreras', 'Ortiz', TO_DATE('1994-11-25','YYYY-MM-DD'), 'Entrenamiento Funcional', 287, 'rocio.contreras522@gmail.com', '994957985');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.223.627-0', 'Pedro', 'Antonio', 'Vásquez', 'Reyes', TO_DATE('1978-01-13','YYYY-MM-DD'), 'CrossFit', 300, 'pedro.vasquez523@gmail.com', '997003335');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('21.926.290-6', 'Claudia', 'Andrea', 'Muñoz', 'Flores', TO_DATE('1990-05-05','YYYY-MM-DD'), 'Nutrición Deportiva', 313, 'claudia.munoz524@gmail.com', '985017167');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.188.185-6', 'Martín', 'Esteban', 'Fernández', 'Ramírez', TO_DATE('1969-04-21','YYYY-MM-DD'), 'Fisioterapia Deportiva', 326, 'martin.fernandez525@gmail.com', '911577597');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.099.226-3', 'Martina', 'Paz', 'Castillo', 'González', TO_DATE('1993-08-17','YYYY-MM-DD'), 'Yoga y Movilidad', 339, 'martina.castillo526@gmail.com', '938081599');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.735.513-5', 'Joaquín', 'Alejandro', 'Soto', 'Riquelme', TO_DATE('1985-01-04','YYYY-MM-DD'), 'Cardio y Resistencia', 6, 'joaquin.soto527@gmail.com', '935186307');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.083.634-0', 'Josefa', 'Alejandra', 'Hernández', 'Herrera', TO_DATE('1987-11-06','YYYY-MM-DD'), 'Hipertrofia', 19, 'josefa.hernandez528@gmail.com', '937698636');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('11.521.428-4', 'Camilo', 'José', 'Soto', 'Navarro', TO_DATE('1990-09-22','YYYY-MM-DD'), 'Acondicionamiento Físico', 32, 'camilo.soto529@gmail.com', '965974034');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.690.306-8', 'Amanda', 'Andrea', 'Contreras', 'González', TO_DATE('1981-01-06','YYYY-MM-DD'), 'Rehabilitación', 45, 'amanda.contreras530@gmail.com', '946356183');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.947.974-8', 'Pedro', 'Antonio', 'Fernández', 'Ramírez', TO_DATE('1979-06-20','YYYY-MM-DD'), 'Musculación y Fuerza', 58, 'pedro.fernandez531@gmail.com', '956111589');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.826.714-7', 'Daniela', 'Paz', 'Ortiz', 'Castillo', TO_DATE('1969-11-16','YYYY-MM-DD'), 'Entrenamiento Funcional', 71, 'daniela.ortiz532@gmail.com', '943568149');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('19.302.111-5', 'Nicolás', NULL, 'Fernández', 'Gutiérrez', TO_DATE('1994-08-07','YYYY-MM-DD'), 'CrossFit', 84, 'nicolas.fernandez533@gmail.com', '944071544');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.362.688-4', 'Javiera', 'Paz', 'Vega', 'Vargas', TO_DATE('1974-10-02','YYYY-MM-DD'), 'Nutrición Deportiva', 97, 'javiera.vega534@gmail.com', '950811259');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.549.625-7', 'Raúl', 'Esteban', 'Pérez', 'Vega', TO_DATE('1992-05-16','YYYY-MM-DD'), 'Fisioterapia Deportiva', 110, 'raul.perez535@gmail.com', '981440325');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('11.953.672-3', 'Renata', 'Ignacia', 'Vega', 'Salazar', TO_DATE('1978-08-11','YYYY-MM-DD'), 'Yoga y Movilidad', 123, 'renata.vega536@gmail.com', '989971027');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.137.754-4', 'Emilio', 'Alejandro', 'Gutiérrez', 'Rodríguez', TO_DATE('1985-03-25','YYYY-MM-DD'), 'Cardio y Resistencia', 136, 'emilio.gutierrez537@gmail.com', '920478103');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.495.290-4', 'Catalina', 'Estefanía', 'Contreras', 'Miranda', TO_DATE('1968-08-08','YYYY-MM-DD'), 'Hipertrofia', 149, 'catalina.contreras538@gmail.com', '938835830');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('23.464.542-0', 'Cristóbal', 'Esteban', 'Vega', 'Salazar', TO_DATE('1984-04-26','YYYY-MM-DD'), 'Acondicionamiento Físico', 162, 'cristobal.vega539@gmail.com', '926976604');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('22.585.374-6', 'Catalina', 'Constanza', 'Martínez', 'Riquelme', TO_DATE('1979-11-13','YYYY-MM-DD'), 'Rehabilitación', 175, 'catalina.martinez540@gmail.com', '953722847');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.541.731-4', 'Pedro', 'Antonio', 'Sepúlveda', 'Miranda', TO_DATE('1990-03-24','YYYY-MM-DD'), 'Musculación y Fuerza', 188, 'pedro.sepulveda541@gmail.com', '983995414');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('20.069.101-6', 'Josefa', 'Andrea', 'Navarro', 'Díaz', TO_DATE('1995-01-09','YYYY-MM-DD'), 'Entrenamiento Funcional', 201, 'josefa.navarro542@gmail.com', '999475391');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.687.336-4', 'Arturo', 'José', 'Rodríguez', 'Martínez', TO_DATE('1985-12-12','YYYY-MM-DD'), 'CrossFit', 214, 'arturo.rodriguez543@gmail.com', '945911099');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.238.128-4', 'Josefa', 'Constanza', 'Morales', 'Rodríguez', TO_DATE('1992-03-22','YYYY-MM-DD'), 'Nutrición Deportiva', 227, 'josefa.morales544@gmail.com', '917199812');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('16.679.821-3', 'Nicolás', 'Esteban', 'García', 'Ortiz', TO_DATE('1968-05-08','YYYY-MM-DD'), 'Fisioterapia Deportiva', 240, 'nicolas.garcia545@gmail.com', '983292329');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('25.380.590-0', 'Paula', 'Alejandra', 'Cortés', 'Soto', TO_DATE('1989-12-14','YYYY-MM-DD'), 'Yoga y Movilidad', 253, 'paula.cortes546@gmail.com', '972497122');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('18.802.211-1', 'Nicolás', 'Alejandro', 'Sepúlveda', 'Vega', TO_DATE('1983-01-02','YYYY-MM-DD'), 'Cardio y Resistencia', 266, 'nicolas.sepulveda547@gmail.com', '915405350');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('14.339.316-K', 'Martina', 'Alejandra', 'Carrasco', 'Araya', TO_DATE('1992-01-06','YYYY-MM-DD'), 'Hipertrofia', 279, 'martina.carrasco548@gmail.com', '954126987');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('24.167.984-5', 'Gabriel', 'Antonio', 'Soto', 'Vásquez', TO_DATE('1981-04-27','YYYY-MM-DD'), 'Acondicionamiento Físico', 292, 'gabriel.soto549@gmail.com', '999039934');
INSERT INTO PREPARADOR_FISICO (rut_prep, pnombre_preparador, snombre_preparador, papellido_preparador, sapellido_preparador, fecha_nac_preparador, especialidad_preparador, COMUNA_id_comuna, correo_preparador, telefono_preparador) VALUES ('17.045.862-1', 'Florencia', 'Antonia', 'Hernández', 'Ortiz', TO_DATE('1979-03-18','YYYY-MM-DD'), 'Rehabilitación', 305, 'florencia.hernandez550@gmail.com', '938549945');

-- PLAN: 10 registros
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (1, 'Plan Inicial', 19990, '1 mes', 'Acceso completo en horario restringido (lunes a viernes hasta las 18:00 hrs).');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (2, 'Plan Básico', 24990, '1 mes', 'Acceso al gimnasio en horario completo y uso de máquinas de musculación.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (3, 'Plan Full', 29990, '1 mes', 'Acceso libre al gimnasio, clases grupales y evaluación física inicial.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (4, 'Plan Full +', 34990, '3 meses', 'Acceso libre, clases grupales y una rutina de entrenamiento personalizada.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (5, 'Plan Trimestral', 39990, '3 meses', 'Entrenamiento libre, clases dirigidas y seguimiento con preparador físico.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (6, 'Plan Semestral', 49990, '6 meses', 'Vigencia de 6 meses, incluye evaluación nutricional y control de métricas.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (7, 'Plan Anual', 59990, '12 meses', 'Vigencia de 12 meses con todos los beneficios del club y 2 evaluaciones anuales.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (8, 'Plan VIP', 79990, '12 meses', 'Entrenamiento personalizado dos veces por semana, plan nutricional y acceso prioritario.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (9, 'Plan Parejas', 44990, '3 meses', 'Acceso para 2 personas con un pago único mensual, incluye evaluación conjunta.');
INSERT INTO PLAN (id_plan, nombre_plan, precio_plan, duracion_plan, descripcion_plan) VALUES (10, 'Plan Estudiantes', 17990, '1 mes', 'Tarifa preferencial para estudiantes, presentando certificado vigente.');

-- CLIENTE: 50 registros
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.998.500-5', 'Franco', 'Luis', 'Sepúlveda', 'Fernández', TO_DATE('2002-02-21','YYYY-MM-DD'), 'Chilena', 2, 8, '940726097', 'franco.sepulveda1@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('15.360.060-0', 'Carla', 'Constanza', 'Fernández', 'Cortés', TO_DATE('1992-07-22','YYYY-MM-DD'), 'Chilena', 3, 15, '943689519', 'carla.fernandez2@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('18.430.815-0', 'Vicente', 'Luis', 'Vargas', 'Vásquez', TO_DATE('1984-05-01','YYYY-MM-DD'), 'Chilena', 4, 22, '937183296', 'vicente.vargas3@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('25.960.879-1', 'Valentina', 'Andrea', 'Miranda', 'Herrera', TO_DATE('2004-08-12','YYYY-MM-DD'), 'Chilena', 5, 29, '980180947', 'valentina.miranda4@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('18.586.960-1', 'Mauricio', 'Antonio', 'Araya', 'Ortiz', TO_DATE('1991-08-26','YYYY-MM-DD'), 'Chilena', 6, 36, '972633522', 'mauricio.araya5@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('20.858.183-K', 'Rocío', NULL, 'Espinoza', 'Castillo', TO_DATE('2004-02-15','YYYY-MM-DD'), 'Chilena', 7, 43, '971425491', 'rocio.espinoza6@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('24.428.415-9', 'Camilo', 'José', 'Tapia', 'Rodríguez', TO_DATE('2001-12-16','YYYY-MM-DD'), 'Chilena', 8, 50, '967146759', 'camilo.tapia7@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('25.987.858-6', 'Antonia', 'Paz', 'Ortiz', 'Gutiérrez', TO_DATE('1981-12-28','YYYY-MM-DD'), 'Chilena', 9, 57, '922973827', 'antonia.ortiz8@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.721.960-7', 'Franco', 'Andrés', 'Tapia', 'Muñoz', TO_DATE('1975-08-19','YYYY-MM-DD'), 'Chilena', 10, 64, '922370664', 'franco.tapia9@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('24.833.068-6', 'Paz', 'Ignacia', 'García', 'López', TO_DATE('1978-10-02','YYYY-MM-DD'), 'Chilena', 1, 71, '943264201', 'paz.garcia10@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('13.746.093-9', 'Sergio', 'José', 'Reyes', 'Sepúlveda', TO_DATE('1985-11-19','YYYY-MM-DD'), 'Chilena', 2, 78, '910688684', 'sergio.reyes11@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('25.012.372-8', 'Amanda', 'Constanza', 'Martínez', 'Cortés', TO_DATE('1990-10-05','YYYY-MM-DD'), 'Chilena', 3, 85, '939920845', 'amanda.martinez12@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('20.083.621-9', 'Alonso', 'José', 'Soto', 'Álvarez', TO_DATE('1980-03-26','YYYY-MM-DD'), 'Chilena', 4, 92, '999731916', 'alonso.soto13@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('20.426.773-1', 'Amanda', 'Paz', 'Vega', 'Álvarez', TO_DATE('2000-03-17','YYYY-MM-DD'), 'Chilena', 5, 99, '962399581', 'amanda.vega14@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('19.337.510-3', 'Arturo', 'Antonio', 'Castro', 'Muñoz', TO_DATE('1987-02-02','YYYY-MM-DD'), 'Chilena', 6, 106, '924245056', 'arturo.castro15@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('17.056.747-1', 'Javiera', 'Alejandra', 'González', 'Vega', TO_DATE('1985-11-10','YYYY-MM-DD'), 'Chilena', 7, 113, '973890916', 'javiera.gonzalez16@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('23.142.824-0', 'Rodrigo', 'Alejandro', 'Silva', 'Ortiz', TO_DATE('1993-10-26','YYYY-MM-DD'), 'Chilena', 8, 120, '972623684', 'rodrigo.silva17@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('19.606.110-K', 'Florencia', 'Andrea', 'Carrasco', 'Salazar', TO_DATE('1988-10-11','YYYY-MM-DD'), 'Chilena', 9, 127, '937781143', 'florencia.carrasco18@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('19.190.751-5', 'Rodrigo', 'Antonio', 'Pérez', 'Riquelme', TO_DATE('1976-04-21','YYYY-MM-DD'), 'Chilena', 10, 134, '963573955', 'rodrigo.perez19@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('24.133.155-5', 'Florencia', NULL, 'Cortés', 'Díaz', TO_DATE('2002-11-07','YYYY-MM-DD'), 'Chilena', 1, 141, '970642368', 'florencia.cortes20@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('22.256.410-7', 'Ignacio', NULL, 'Martínez', 'Salazar', TO_DATE('2000-09-05','YYYY-MM-DD'), 'Chilena', 2, 148, '939356575', 'ignacio.martinez21@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('23.028.725-2', 'Florencia', 'Andrea', 'Castro', 'Flores', TO_DATE('1992-07-28','YYYY-MM-DD'), 'Chilena', 3, 155, '967090084', 'florencia.castro22@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('22.886.836-1', 'Andrés', 'Esteban', 'Valenzuela', 'Rodríguez', TO_DATE('1980-05-15','YYYY-MM-DD'), 'Chilena', 4, 162, '956179753', 'andres.valenzuela23@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('18.236.009-0', 'Daniela', 'Estefanía', 'Espinoza', 'Herrera', TO_DATE('1985-09-16','YYYY-MM-DD'), 'Chilena', 5, 169, '933751475', 'daniela.espinoza24@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('22.600.124-7', 'Rodrigo', 'Ignacio', 'Salazar', 'Flores', TO_DATE('2002-04-08','YYYY-MM-DD'), 'Chilena', 6, 176, '922692439', 'rodrigo.salazar25@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('22.970.008-1', 'Camila', 'Ignacia', 'Herrera', 'Ramírez', TO_DATE('1992-11-06','YYYY-MM-DD'), 'Chilena', 7, 183, '964761163', 'camila.herrera26@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('19.840.186-2', 'Matías', 'Alejandro', 'Morales', 'Reyes', TO_DATE('1996-10-26','YYYY-MM-DD'), 'Chilena', 8, 190, '985430704', 'matias.morales27@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('17.400.346-7', 'Paz', 'Antonia', 'Silva', 'García', TO_DATE('1992-10-24','YYYY-MM-DD'), 'Chilena', 9, 197, '947644351', 'paz.silva28@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('14.025.425-8', 'Cristóbal', 'José', 'Navarro', 'Flores', TO_DATE('1992-03-04','YYYY-MM-DD'), 'Chilena', 10, 204, '999967131', 'cristobal.navarro29@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('10.042.527-0', 'Catalina', 'Ignacia', 'Vásquez', 'Morales', TO_DATE('1996-01-25','YYYY-MM-DD'), 'Chilena', 1, 211, '924231875', 'catalina.vasquez30@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('20.304.637-5', 'Benjamín', 'Andrés', 'Contreras', 'Vega', TO_DATE('1983-10-27','YYYY-MM-DD'), 'Chilena', 2, 218, '952084090', 'benjamin.contreras31@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.354.318-3', 'Antonia', 'Paz', 'Castillo', 'Morales', TO_DATE('1983-02-01','YYYY-MM-DD'), 'Chilena', 3, 225, '945011808', 'antonia.castillo32@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.857.850-3', 'Franco', 'José', 'Álvarez', 'Muñoz', TO_DATE('1978-04-01','YYYY-MM-DD'), 'Chilena', 4, 232, '917692234', 'franco.alvarez33@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('14.819.091-7', 'Fernanda', 'Ignacia', 'Contreras', 'Riquelme', TO_DATE('2004-06-11','YYYY-MM-DD'), 'Chilena', 5, 239, '987373976', 'fernanda.contreras34@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('23.702.981-K', 'Sergio', 'Luis', 'Miranda', 'García', TO_DATE('2004-07-11','YYYY-MM-DD'), 'Chilena', 6, 246, '915101730', 'sergio.miranda35@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('11.645.033-K', 'Renata', 'Antonia', 'Miranda', 'Herrera', TO_DATE('1996-02-22','YYYY-MM-DD'), 'Chilena', 7, 253, '967193390', 'renata.miranda36@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('17.543.956-0', 'Benjamín', 'José', 'Castro', 'Espinoza', TO_DATE('1976-12-23','YYYY-MM-DD'), 'Chilena', 8, 260, '957824180', 'benjamin.castro37@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('10.192.750-4', 'Rocío', NULL, 'Espinoza', 'Ramírez', TO_DATE('1998-02-10','YYYY-MM-DD'), 'Chilena', 9, 267, '948863507', 'rocio.espinoza38@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('23.669.449-6', 'Sergio', 'Esteban', 'Castillo', 'Carrasco', TO_DATE('1992-06-07','YYYY-MM-DD'), 'Chilena', 10, 274, '912720605', 'sergio.castillo39@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('24.947.890-3', 'Paz', NULL, 'Silva', 'Morales', TO_DATE('1978-02-02','YYYY-MM-DD'), 'Chilena', 1, 281, '993076786', 'paz.silva40@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('21.495.380-3', 'Nicolás', 'Alejandro', 'Miranda', 'Valenzuela', TO_DATE('1988-10-05','YYYY-MM-DD'), 'Chilena', 2, 288, '913864688', 'nicolas.miranda41@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('18.225.646-3', 'Javiera', 'Estefanía', 'Castro', 'Torres', TO_DATE('1996-04-25','YYYY-MM-DD'), 'Chilena', 3, 295, '966503709', 'javiera.castro42@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('21.398.255-9', 'Nicolás', 'Andrés', 'Cortés', 'González', TO_DATE('1997-09-22','YYYY-MM-DD'), 'Chilena', 4, 302, '998793440', 'nicolas.cortes43@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('15.271.957-4', 'Paz', 'Estefanía', 'Araya', 'Sepúlveda', TO_DATE('1975-01-09','YYYY-MM-DD'), 'Chilena', 5, 309, '940635974', 'paz.araya44@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('13.526.984-0', 'Pedro', 'Luis', 'Álvarez', 'Araya', TO_DATE('1979-11-19','YYYY-MM-DD'), 'Chilena', 6, 316, '952244317', 'pedro.alvarez45@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('16.664.202-7', 'Antonia', 'Andrea', 'Riquelme', 'Rojas', TO_DATE('2002-09-27','YYYY-MM-DD'), 'Chilena', 7, 323, '997270142', 'antonia.riquelme46@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('14.219.689-1', 'Joaquín', 'Alejandro', 'Salazar', 'Castillo', TO_DATE('1996-01-21','YYYY-MM-DD'), 'Chilena', 8, 330, '917550517', 'joaquin.salazar47@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('15.832.730-9', 'Isidora', 'Constanza', 'Díaz', 'Hernández', TO_DATE('2002-03-24','YYYY-MM-DD'), 'Chilena', 9, 337, '978265854', 'isidora.diaz48@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('25.591.357-3', 'Iván', 'Esteban', 'Gutiérrez', 'Hernández', TO_DATE('2001-05-11','YYYY-MM-DD'), 'Chilena', 10, 344, '985375365', 'ivan.gutierrez49@gmail.com');
INSERT INTO CLIENTE (rut_cliente, pnombre_cliente, snombre_cliente, papellido_cliente, sapellido_cliente, fecha_nac_cliente, nacionalidad_cliente, PLAN_id_plan, COMUNA_id_comuna, telefono_cliente, correo_cliente) VALUES ('15.983.360-7', 'Trinidad', 'Alejandra', 'Reyes', 'Herrera', TO_DATE('1989-09-26','YYYY-MM-DD'), 'Chilena', 1, 5, '995498222', 'trinidad.reyes50@gmail.com');

-- AGENDA: 50 registros
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (1, TO_DATE('2026-02-23','YYYY-MM-DD'), INTERVAL '0 16:45:00' DAY TO SECOND, 'Agendada', '23.507.938-0', '11.998.500-5');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (2, TO_DATE('2025-09-28','YYYY-MM-DD'), INTERVAL '0 15:00:00' DAY TO SECOND, 'Completada', '16.314.012-8', '15.360.060-0');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (3, TO_DATE('2025-04-11','YYYY-MM-DD'), INTERVAL '0 09:30:00' DAY TO SECOND, 'Agendada', '22.515.298-5', '18.430.815-0');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (4, TO_DATE('2026-04-09','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Completada', '18.616.569-1', '25.960.879-1');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (5, TO_DATE('2026-01-22','YYYY-MM-DD'), INTERVAL '0 13:30:00' DAY TO SECOND, 'Completada', '20.699.123-2', '18.586.960-1');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (6, TO_DATE('2026-03-19','YYYY-MM-DD'), INTERVAL '0 10:45:00' DAY TO SECOND, 'Agendada', '11.280.435-8', '20.858.183-K');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (7, TO_DATE('2026-08-09','YYYY-MM-DD'), INTERVAL '0 09:15:00' DAY TO SECOND, 'Completada', '22.131.805-6', '24.428.415-9');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (8, TO_DATE('2026-08-28','YYYY-MM-DD'), INTERVAL '0 16:00:00' DAY TO SECOND, 'Completada', '15.710.873-5', '25.987.858-6');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (9, TO_DATE('2025-09-05','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Completada', '11.504.328-5', '11.721.960-7');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (10, TO_DATE('2026-05-13','YYYY-MM-DD'), INTERVAL '0 07:15:00' DAY TO SECOND, 'Agendada', '19.352.468-0', '24.833.068-6');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (11, TO_DATE('2025-03-13','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '19.027.228-1', '13.746.093-9');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (12, TO_DATE('2025-10-12','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Agendada', '14.900.991-4', '25.012.372-8');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (13, TO_DATE('2026-08-26','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '14.825.159-2', '20.083.621-9');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (14, TO_DATE('2025-12-18','YYYY-MM-DD'), INTERVAL '0 13:15:00' DAY TO SECOND, 'Completada', '17.674.700-5', '20.426.773-1');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (15, TO_DATE('2025-02-02','YYYY-MM-DD'), INTERVAL '0 15:15:00' DAY TO SECOND, 'Pendiente', '12.363.714-3', '19.337.510-3');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (16, TO_DATE('2025-12-02','YYYY-MM-DD'), INTERVAL '0 18:00:00' DAY TO SECOND, 'Completada', '24.704.807-3', '17.056.747-1');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (17, TO_DATE('2026-08-27','YYYY-MM-DD'), INTERVAL '0 19:30:00' DAY TO SECOND, 'Completada', '20.817.865-2', '23.142.824-0');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (18, TO_DATE('2025-01-16','YYYY-MM-DD'), INTERVAL '0 07:45:00' DAY TO SECOND, 'Completada', '21.810.749-4', '19.606.110-K');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (19, TO_DATE('2025-01-19','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Completada', '22.019.455-8', '19.190.751-5');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (20, TO_DATE('2025-08-25','YYYY-MM-DD'), INTERVAL '0 15:45:00' DAY TO SECOND, 'Agendada', '19.687.556-5', '24.133.155-5');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (21, TO_DATE('2025-04-25','YYYY-MM-DD'), INTERVAL '0 08:30:00' DAY TO SECOND, 'Completada', '15.184.138-4', '22.256.410-7');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (22, TO_DATE('2025-08-07','YYYY-MM-DD'), INTERVAL '0 08:45:00' DAY TO SECOND, 'Completada', '10.415.056-K', '23.028.725-2');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (23, TO_DATE('2025-01-12','YYYY-MM-DD'), INTERVAL '0 15:00:00' DAY TO SECOND, 'Completada', '24.223.627-0', '22.886.836-1');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (24, TO_DATE('2026-01-07','YYYY-MM-DD'), INTERVAL '0 20:00:00' DAY TO SECOND, 'Completada', '21.926.290-6', '18.236.009-0');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (25, TO_DATE('2025-05-17','YYYY-MM-DD'), INTERVAL '0 10:15:00' DAY TO SECOND, 'Completada', '16.188.185-6', '22.600.124-7');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (26, TO_DATE('2026-08-23','YYYY-MM-DD'), INTERVAL '0 18:15:00' DAY TO SECOND, 'Completada', '16.099.226-3', '22.970.008-1');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (27, TO_DATE('2025-07-23','YYYY-MM-DD'), INTERVAL '0 12:15:00' DAY TO SECOND, 'Completada', '17.735.513-5', '19.840.186-2');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (28, TO_DATE('2026-02-04','YYYY-MM-DD'), INTERVAL '0 13:30:00' DAY TO SECOND, 'Completada', '17.083.634-0', '17.400.346-7');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (29, TO_DATE('2026-07-08','YYYY-MM-DD'), INTERVAL '0 18:45:00' DAY TO SECOND, 'Completada', '11.521.428-4', '14.025.425-8');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (30, TO_DATE('2026-02-03','YYYY-MM-DD'), INTERVAL '0 18:15:00' DAY TO SECOND, 'Pendiente', '16.690.306-8', '10.042.527-0');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (31, TO_DATE('2025-03-01','YYYY-MM-DD'), INTERVAL '0 14:15:00' DAY TO SECOND, 'Completada', '24.947.974-8', '20.304.637-5');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (32, TO_DATE('2025-09-08','YYYY-MM-DD'), INTERVAL '0 14:45:00' DAY TO SECOND, 'Completada', '19.826.714-7', '11.354.318-3');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (33, TO_DATE('2025-01-28','YYYY-MM-DD'), INTERVAL '0 18:00:00' DAY TO SECOND, 'Completada', '19.302.111-5', '11.857.850-3');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (34, TO_DATE('2026-01-21','YYYY-MM-DD'), INTERVAL '0 17:15:00' DAY TO SECOND, 'Agendada', '18.362.688-4', '14.819.091-7');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (35, TO_DATE('2025-01-01','YYYY-MM-DD'), INTERVAL '0 20:45:00' DAY TO SECOND, 'Completada', '24.549.625-7', '23.702.981-K');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (36, TO_DATE('2026-03-13','YYYY-MM-DD'), INTERVAL '0 17:00:00' DAY TO SECOND, 'Completada', '11.953.672-3', '11.645.033-K');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (37, TO_DATE('2025-08-03','YYYY-MM-DD'), INTERVAL '0 09:00:00' DAY TO SECOND, 'Agendada', '17.137.754-4', '17.543.956-0');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (38, TO_DATE('2026-08-04','YYYY-MM-DD'), INTERVAL '0 12:45:00' DAY TO SECOND, 'Completada', '18.495.290-4', '10.192.750-4');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (39, TO_DATE('2026-06-06','YYYY-MM-DD'), INTERVAL '0 07:45:00' DAY TO SECOND, 'Completada', '23.464.542-0', '23.669.449-6');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (40, TO_DATE('2025-01-03','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Agendada', '22.585.374-6', '24.947.890-3');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (41, TO_DATE('2025-07-15','YYYY-MM-DD'), INTERVAL '0 10:45:00' DAY TO SECOND, 'Completada', '24.541.731-4', '21.495.380-3');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (42, TO_DATE('2025-09-23','YYYY-MM-DD'), INTERVAL '0 19:45:00' DAY TO SECOND, 'Agendada', '20.069.101-6', '18.225.646-3');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (43, TO_DATE('2025-03-25','YYYY-MM-DD'), INTERVAL '0 12:15:00' DAY TO SECOND, 'Completada', '24.687.336-4', '21.398.255-9');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (44, TO_DATE('2026-08-01','YYYY-MM-DD'), INTERVAL '0 11:15:00' DAY TO SECOND, 'Completada', '18.238.128-4', '15.271.957-4');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (45, TO_DATE('2026-08-20','YYYY-MM-DD'), INTERVAL '0 09:45:00' DAY TO SECOND, 'Completada', '16.679.821-3', '13.526.984-0');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (46, TO_DATE('2025-10-23','YYYY-MM-DD'), INTERVAL '0 11:45:00' DAY TO SECOND, 'Pendiente', '25.380.590-0', '16.664.202-7');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (47, TO_DATE('2025-04-20','YYYY-MM-DD'), INTERVAL '0 20:30:00' DAY TO SECOND, 'Completada', '18.802.211-1', '14.219.689-1');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (48, TO_DATE('2025-12-07','YYYY-MM-DD'), INTERVAL '0 07:00:00' DAY TO SECOND, 'Agendada', '14.339.316-K', '15.832.730-9');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (49, TO_DATE('2025-08-02','YYYY-MM-DD'), INTERVAL '0 18:30:00' DAY TO SECOND, 'Agendada', '24.167.984-5', '25.591.357-3');
INSERT INTO AGENDA (id_agendar, fecha_agendar, hora_agendar, estado_agendar, PREPARADOR_FISICO_rut_prep, CLIENTE_rut_cliente) VALUES (50, TO_DATE('2025-08-22','YYYY-MM-DD'), INTERVAL '0 18:00:00' DAY TO SECOND, 'Completada', '17.045.862-1', '15.983.360-7');

-- BLOQUE_HORARIO: 50 registros
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (1, 'Lunes', INTERVAL '0 13:00:00' DAY TO SECOND, 1, TO_DATE('2026-02-23','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (2, 'Domingo', INTERVAL '0 18:30:00' DAY TO SECOND, 2, TO_DATE('2025-09-28','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (3, 'Viernes', INTERVAL '0 08:30:00' DAY TO SECOND, 3, TO_DATE('2025-04-11','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (4, 'Jueves', INTERVAL '0 08:00:00' DAY TO SECOND, 4, TO_DATE('2026-04-09','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (5, 'Jueves', INTERVAL '0 09:30:00' DAY TO SECOND, 5, TO_DATE('2026-01-22','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (6, 'Jueves', INTERVAL '0 10:00:00' DAY TO SECOND, 6, TO_DATE('2026-03-19','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (7, 'Domingo', INTERVAL '0 17:30:00' DAY TO SECOND, 7, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (8, 'Viernes', INTERVAL '0 08:30:00' DAY TO SECOND, 8, TO_DATE('2026-08-28','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (9, 'Viernes', INTERVAL '0 12:30:00' DAY TO SECOND, 9, TO_DATE('2025-09-05','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (10, 'Miércoles', INTERVAL '0 07:30:00' DAY TO SECOND, 10, TO_DATE('2026-05-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (11, 'Jueves', INTERVAL '0 15:00:00' DAY TO SECOND, 11, TO_DATE('2025-03-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (12, 'Domingo', INTERVAL '0 19:00:00' DAY TO SECOND, 12, TO_DATE('2025-10-12','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (13, 'Miércoles', INTERVAL '0 12:30:00' DAY TO SECOND, 13, TO_DATE('2026-08-26','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (14, 'Jueves', INTERVAL '0 10:00:00' DAY TO SECOND, 14, TO_DATE('2025-12-18','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (15, 'Domingo', INTERVAL '0 13:00:00' DAY TO SECOND, 15, TO_DATE('2025-02-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (16, 'Martes', INTERVAL '0 07:00:00' DAY TO SECOND, 16, TO_DATE('2025-12-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (17, 'Jueves', INTERVAL '0 17:00:00' DAY TO SECOND, 17, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (18, 'Jueves', INTERVAL '0 09:00:00' DAY TO SECOND, 18, TO_DATE('2025-01-16','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (19, 'Domingo', INTERVAL '0 12:00:00' DAY TO SECOND, 19, TO_DATE('2025-01-19','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (20, 'Lunes', INTERVAL '0 09:00:00' DAY TO SECOND, 20, TO_DATE('2025-08-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (21, 'Viernes', INTERVAL '0 12:00:00' DAY TO SECOND, 21, TO_DATE('2025-04-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (22, 'Jueves', INTERVAL '0 07:30:00' DAY TO SECOND, 22, TO_DATE('2025-08-07','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (23, 'Domingo', INTERVAL '0 18:00:00' DAY TO SECOND, 23, TO_DATE('2025-01-12','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (24, 'Miércoles', INTERVAL '0 08:30:00' DAY TO SECOND, 24, TO_DATE('2026-01-07','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (25, 'Sábado', INTERVAL '0 15:00:00' DAY TO SECOND, 25, TO_DATE('2025-05-17','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (26, 'Domingo', INTERVAL '0 16:30:00' DAY TO SECOND, 26, TO_DATE('2026-08-23','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (27, 'Miércoles', INTERVAL '0 20:00:00' DAY TO SECOND, 27, TO_DATE('2025-07-23','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (28, 'Miércoles', INTERVAL '0 19:00:00' DAY TO SECOND, 28, TO_DATE('2026-02-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (29, 'Miércoles', INTERVAL '0 11:00:00' DAY TO SECOND, 29, TO_DATE('2026-07-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (30, 'Martes', INTERVAL '0 16:00:00' DAY TO SECOND, 30, TO_DATE('2026-02-03','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (31, 'Sábado', INTERVAL '0 20:00:00' DAY TO SECOND, 31, TO_DATE('2025-03-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (32, 'Lunes', INTERVAL '0 19:00:00' DAY TO SECOND, 32, TO_DATE('2025-09-08','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (33, 'Martes', INTERVAL '0 15:30:00' DAY TO SECOND, 33, TO_DATE('2025-01-28','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (34, 'Miércoles', INTERVAL '0 18:00:00' DAY TO SECOND, 34, TO_DATE('2026-01-21','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (35, 'Miércoles', INTERVAL '0 20:00:00' DAY TO SECOND, 35, TO_DATE('2025-01-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (36, 'Viernes', INTERVAL '0 12:00:00' DAY TO SECOND, 36, TO_DATE('2026-03-13','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (37, 'Domingo', INTERVAL '0 18:00:00' DAY TO SECOND, 37, TO_DATE('2025-08-03','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (38, 'Martes', INTERVAL '0 18:00:00' DAY TO SECOND, 38, TO_DATE('2026-08-04','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (39, 'Sábado', INTERVAL '0 09:00:00' DAY TO SECOND, 39, TO_DATE('2026-06-06','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (40, 'Viernes', INTERVAL '0 10:30:00' DAY TO SECOND, 40, TO_DATE('2025-01-03','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (41, 'Martes', INTERVAL '0 10:30:00' DAY TO SECOND, 41, TO_DATE('2025-07-15','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (42, 'Martes', INTERVAL '0 19:30:00' DAY TO SECOND, 42, TO_DATE('2025-09-23','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (43, 'Martes', INTERVAL '0 14:30:00' DAY TO SECOND, 43, TO_DATE('2025-03-25','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (44, 'Sábado', INTERVAL '0 07:30:00' DAY TO SECOND, 44, TO_DATE('2026-08-01','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (45, 'Jueves', INTERVAL '0 18:00:00' DAY TO SECOND, 45, TO_DATE('2026-08-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (46, 'Jueves', INTERVAL '0 12:30:00' DAY TO SECOND, 46, TO_DATE('2025-10-23','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (47, 'Domingo', INTERVAL '0 09:30:00' DAY TO SECOND, 47, TO_DATE('2025-04-20','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (48, 'Domingo', INTERVAL '0 20:30:00' DAY TO SECOND, 48, TO_DATE('2025-12-07','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (49, 'Sábado', INTERVAL '0 15:30:00' DAY TO SECOND, 49, TO_DATE('2025-08-02','YYYY-MM-DD'));
INSERT INTO BLOQUE_HORARIO (id_bloque, dia_bloque, hora_bloque, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (50, 'Viernes', INTERVAL '0 11:00:00' DAY TO SECOND, 50, TO_DATE('2025-08-22','YYYY-MM-DD'));

-- CAT_PATOLOGIA: 51 registros
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (1, 'Cardiovascular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (2, 'Respiratoria');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (3, 'Metabólica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (4, 'Osteoarticular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (5, 'Muscular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (6, 'Neurológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (7, 'Digestiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (8, 'Autoinmune');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (9, 'Endocrina');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (10, 'Renal');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (11, 'Hematológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (12, 'Dermatológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (13, 'Oncológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (14, 'Infecciosa');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (15, 'Ortopédica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (16, 'Ósea');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (17, 'Articular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (18, 'Traumatológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (19, 'Psicológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (20, 'Psiquiátrica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (21, 'Oftálmica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (22, 'Otorrinolaringológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (23, 'Auditiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (24, 'Visual');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (25, 'Dental');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (26, 'Nutricional');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (27, 'Genética');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (28, 'Congénita');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (29, 'Pediátrica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (30, 'Geriátrica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (31, 'Deportiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (32, 'Laboral');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (33, 'Alérgica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (34, 'Inflamatoria');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (35, 'Degenerativa');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (36, 'Fisiológica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (37, 'Afectiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (38, 'Hepática');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (39, 'Tiroidea');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (40, 'Pulmonar');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (41, 'Cardíaca');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (42, 'Vascular');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (43, 'Coronaria');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (44, 'Renal crónica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (45, 'Digestiva crónica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (46, 'Ósea metabólica');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (47, 'Del sueño');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (48, 'Sensorial');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (49, 'Motora');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (50, 'Cognitiva');
INSERT INTO CAT_PATOLOGIA (id_cat, nombre_categoria) VALUES (51, 'Sin Patologías');

-- CENTRO_DEP: 50 registros
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (1, 'Centro Deportivo Central Santiago', '76.101.234-7', 113, 'Av. Libertador Bernardo O''Higgins 1234''');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (2, 'Centro Deportivo Providencia Sport', '76.202.345-8', 104, 'Av. Providencia 2150');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (3, 'Centro Deportivo Las Condes Fitness', '76.303.456-9', 95, 'Av. Apoquindo 4500');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (4, 'Centro Deportivo Ñuñoa Activa', '76.404.567-K', 101, 'Av. Irarrázaval 3205');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (5, 'Centro Deportivo Maipú Fuerza', '76.505.678-0', 100, 'Av. Pajaritos 1890');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (6, 'Centro Deportivo La Florida Gym', '76.606.789-1', 91, 'Av. Vicuña Mackenna 7200');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (7, 'Centro Deportivo Viña Marina', '77.101.890-4', 51, 'Av. Libertad 850');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (8, 'Centro Deportivo Valparaíso Puerto', '77.202.901-2', 50, 'Calle Condell 1420');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (9, 'Centro Deportivo Antofagasta Costa', '77.303.012-K', 12, 'Av. Grecia 1650');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (10, 'Centro Deportivo La Serena Sol', '77.404.123-0', 33, 'Av. Francisco de Aguirre 420');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (11, 'Centro Deportivo Rancagua Salud', '77.505.234-1', 148, 'Paseo Independencia 630');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (12, 'Centro Deportivo Talca Centro', '77.606.345-2', 186, 'Calle 1 Sur 1120');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (13, 'Centro Deportivo Concepción Bío Bío', '78.101.456-7', 220, 'Calle Barros Arana 780');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (14, 'Centro Deportivo Temuco Araucanía', '78.202.567-8', 268, 'Av. Alemania 0825');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (15, 'Centro Deportivo Puerto Montt Sur', '78.303.678-9', 303, 'Av. Diego Portales 1500');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (16, 'Centro Deportivo Pozo Almonte Fit Club', '77.772.477-0', 7, 'Av. Pozo Almonte 1123');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (17, 'Centro Deportivo Tocopilla Power Gym', '77.706.003-1', 19, 'Av. Tocopilla 1246');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (18, 'Centro Deportivo Vallenar Athletic', '77.835.268-0', 26, 'Av. Vallenar 1369');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (19, 'Centro Deportivo Ovalle Elite Performance', '77.208.624-5', 40, 'Av. Ovalle 1492');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (20, 'Centro Deportivo Los Andes Box Training', '77.868.600-7', 53, 'Av. Los Andes 1615');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (21, 'Centro Deportivo San Antonio Zone Fitness', '77.316.367-7', 67, 'Av. San Antonio 1738');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (22, 'Centro Deportivo Santiago Sport Center', '77.207.659-2', 83, 'Av. Santiago 1861');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (23, 'Centro Deportivo San Bernardo Academy', '77.449.354-9', 121, 'Av. San Bernardo 1984');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (24, 'Centro Deportivo Rancagua Peak Training', '77.854.555-1', 135, 'Av. Rancagua 2107');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (25, 'Centro Deportivo Curicó Life Gym', '77.117.844-8', 168, 'Av. Curicó 2230');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (26, 'Centro Deportivo Cauquenes Energy Club', '77.992.087-9', 195, 'Av. Cauquenes 2353');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (27, 'Centro Deportivo San Carlos Core Fitness', '77.523.863-1', 214, 'Av. San Carlos 2476');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (28, 'Centro Deportivo Los Ángeles Strength House', '77.913.801-1', 238, 'Av. Los Ángeles 2599');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (29, 'Centro Deportivo Valdivia Movement Studio', '77.408.466-5', 284, 'Av. Valdivia 2722');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (30, 'Centro Deportivo Osorno Health Club', '77.237.147-0', 306, 'Av. Osorno 2845');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (31, 'Centro Deportivo Coyhaique Iron Gym', '77.686.514-1', 326, 'Av. Coyhaique 2968');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (32, 'Centro Deportivo Chile Chico Active Center', '77.569.846-2', 334, 'Av. Chile Chico 3091');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (33, 'Centro Deportivo Porvenir Total Fitness', '77.849.770-0', 342, 'Av. Porvenir 3214');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (34, 'Centro Deportivo Putre Body Studio', '77.267.058-3', 3, 'Av. Putre 3337');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (35, 'Centro Deportivo Antofagasta Oxygen Club', '77.141.967-4', 12, 'Av. Antofagasta 3460');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (36, 'Centro Deportivo Copiapó Training Lab', '77.165.367-7', 21, 'Av. Copiapó 3583');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (37, 'Centro Deportivo La Serena Iron House', '77.219.595-8', 30, 'Av. La Serena 3706');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (38, 'Centro Deportivo Valparaíso Fit House', '77.261.137-4', 45, 'Av. Valparaíso 3829');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (39, 'Centro Deportivo La Ligua Performance Club', '77.304.673-5', 57, 'Av. La Ligua 3952');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (40, 'Centro Deportivo San Felipe Gym Center', '77.363.478-5', 73, 'Av. San Felipe 4075');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (41, 'Centro Deportivo Puente Alto Fit Club', '77.780.814-1', 115, 'Av. Puente Alto 4198');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (42, 'Centro Deportivo Melipilla Power Gym', '77.113.316-9', 125, 'Av. Melipilla 4321');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (43, 'Centro Deportivo Pichilemu Athletic', '77.392.503-8', 152, 'Av. Pichilemu 4444');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (44, 'Centro Deportivo Talca Elite Performance', '77.866.419-4', 177, 'Av. Talca 4567');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (45, 'Centro Deportivo Chillán Box Training', '77.619.668-1', 198, 'Av. Chillán 4690');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (46, 'Centro Deportivo Concepción Zone Fitness', '77.578.915-8', 219, 'Av. Concepción 4813');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (47, 'Centro Deportivo Temuco Sport Center', '77.783.716-8', 252, 'Av. Temuco 4936');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (48, 'Centro Deportivo La Unión Academy', '77.855.994-3', 292, 'Av. La Unión 5059');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (49, 'Centro Deportivo Castro Peak Training', '77.272.819-0', 312, 'Av. Castro 5182');
INSERT INTO CENTRO_DEP (id_centro, nombre_centro, rut_centro, COMUNA_id_comuna, dir_centro) VALUES (50, 'Centro Deportivo Puerto Aysén Life Gym', '77.614.375-8', 328, 'Av. Puerto Aysén 5305');

-- EJERCICIO: 50 registros
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (1, 'Sentadilla', 'Sentadilla con barra sobre la espalda, bajando hasta que los muslos queden paralelos al suelo.', 12, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (2, 'Press de banca', 'Press de banca con barra, enfocado en el desarrollo del pectoral mayor.', 10, 50);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (3, 'Peso muerto', 'Levantamiento de barra desde el suelo con espalda recta, activando la cadena posterior.', 8, 80);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (4, 'Dominadas', 'Dominadas en barra con agarre prono, trabajando dorsal y bíceps.', 10, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (5, 'Fondos', 'Fondos en paralelas para tríceps y pectoral inferior.', 12, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (6, 'Remo con barra', 'Remo con barra inclinado, enfocado en la espalda media.', 10, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (7, 'Press militar', 'Press militar con barra por encima de la cabeza para hombros.', 10, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (8, 'Curl de bíceps', 'Curl de bíceps con barra recta, manteniendo los codos pegados al cuerpo.', 12, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (9, 'Extensiones de tríceps', 'Extensiones de tríceps en polea alta.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (10, 'Press francés', 'Press francés con barra Z para tríceps.', 12, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (11, 'Sentadilla búlgara', 'Sentadilla búlgara con mancuernas, dividiendo el trabajo en cada pierna.', 12, 10);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (12, 'Zancadas', 'Zancadas alternadas con mancuernas, trabajando glúteos y cuádriceps.', 12, 12);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (13, 'Peso muerto rumano', 'Peso muerto rumano con barra para isquiotibiales y glúteos.', 10, 50);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (14, 'Hip thrust', 'Elevación de cadera con barra apoyada, enfocado en glúteos.', 12, 60);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (15, 'Puente de glúteos', 'Puente de glúteos con peso o banda elástica.', 15, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (16, 'Elevaciones laterales', 'Elevaciones laterales con mancuernas para hombros.', 15, 8);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (17, 'Elevaciones frontales', 'Elevaciones frontales con mancuernas para deltoides anterior.', 15, 8);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (18, 'Pájaros', 'Remo en pronación con mancuernas para deltoides posterior.', 15, 6);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (19, 'Remo en máquina', 'Remo en máquina sentado con agarre cerrado.', 12, 45);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (20, 'Jalón al pecho', 'Jalón al pecho en polea alta con agarre amplio.', 12, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (21, 'Jalón al mentón', 'Remo alto al mentón con barra.', 12, 25);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (22, 'Aperturas en máquina', 'Aperturas de pecho en máquina.', 12, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (23, 'Cruce de poleas', 'Cruce de poleas altas, enfocado en el pectoral.', 12, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (24, 'Face pull', 'Face pull en polea alta con cuerda.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (25, 'Encogimientos de hombros', 'Encogimientos con mancuernas para trapecios.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (26, 'Abdominales en máquina', 'Crunch abdominal en máquina.', 20, 25);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (27, 'Plancha', 'Plancha abdominal isométrica manteniendo el cuerpo recto.', 60, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (28, 'Palof press', 'Rotación resistida con polea para core, de pie.', 15, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (29, 'Russian twist', 'Giro ruso con disco o mancuerna.', 20, 10);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (30, 'Elevación de piernas colgado', 'Elevaciones de piernas en barra fija.', 12, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (31, 'Burpees', 'Burpees completos con salto final.', 15, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (32, 'Saltos al cajón', 'Saltos pliométricos sobre cajón.', 10, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (33, 'Sprints en cinta', 'Sprints en cinta a máxima intensidad.', 10, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (34, 'Skipping alto', 'Skipping con rodillas altas en el lugar.', 30, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (35, 'Escalador', 'Escalador de montaña, alternando rodillas al pecho.', 30, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (36, 'Mountain climbers', 'Escaladores en posición de plancha.', 40, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (37, 'Flexiones', 'Flexiones de pecho con apoyo de manos al piso.', 20, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (38, 'Flexiones diamante', 'Flexiones con manos juntas formando un diamante.', 12, 0);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (39, 'Curl martillo', 'Curl de bíceps con agarre neutro.', 12, 12);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (40, 'Curl concentrado', 'Curl concentrado sentado con mancuerna.', 12, 10);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (41, 'Extensiones en polea', 'Extensiones de tríceps en polea baja.', 15, 20);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (42, 'Peso muerto sumo', 'Peso muerto con agarre ancho y postura sumo.', 8, 70);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (43, 'Sentadilla frontal', 'Sentadilla frontal con barra.', 10, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (44, 'Prensa de piernas', 'Prensa inclinada de piernas en máquina.', 12, 120);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (45, 'Extensiones de cuádriceps', 'Extensión de piernas en máquina.', 15, 35);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (46, 'Curl femoral', 'Curl de pierna acostado en máquina.', 12, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (47, 'Gemelos de pie', 'Elevación de talones de pie, trabajo de gemelos.', 20, 40);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (48, 'Gemelos sentado', 'Elevación de talones sentado con lastre.', 20, 30);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (49, 'Remo con mancuerna', 'Remo a una mano con mancuerna apoyado en una banca.', 12, 15);
INSERT INTO EJERCICIO (id_ejercicio, nombre_ejercicio, descripcion_ejercicio, repeticiones_ejercicio, peso_ejercicio) VALUES (50, 'Band pull apart', 'Apertura de banda elástica frente al pecho.', 20, 0);

-- RUTINA: 50 registros
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (1, 'Rutina de hipertrofia 1', '11.998.500-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (2, 'Rutina Full Body A 2', '15.360.060-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (3, 'Rutina Full Body B 3', '18.430.815-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (4, 'Rutina Push Day 4', '25.960.879-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (5, 'Rutina Pull Day 5', '18.586.960-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (6, 'Rutina de piernas 6', '20.858.183-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (7, 'Rutina de espalda 7', '24.428.415-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (8, 'Rutina de pecho 8', '25.987.858-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (9, 'Rutina de hombros 9', '11.721.960-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (10, 'Rutina de brazos 10', '24.833.068-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (11, 'Rutina funcional 11', '13.746.093-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (12, 'Rutina de fuerza 12', '25.012.372-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (13, 'Rutina cardio HIIT 13', '20.083.621-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (14, 'Rutina de definición 14', '20.426.773-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (15, 'Rutina de resistencia 15', '19.337.510-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (16, 'Rutina de inicio 16', '17.056.747-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (17, 'Rutina avanzada 17', '23.142.824-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (18, 'Rutina de glúteos 18', '19.606.110-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (19, 'Rutina de torso 19', '19.190.751-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (20, 'Rutina de abdomen 20', '24.133.155-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (21, 'Rutina de hipertrofia 21', '22.256.410-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (22, 'Rutina Full Body A 22', '23.028.725-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (23, 'Rutina Full Body B 23', '22.886.836-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (24, 'Rutina Push Day 24', '18.236.009-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (25, 'Rutina Pull Day 25', '22.600.124-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (26, 'Rutina de piernas 26', '22.970.008-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (27, 'Rutina de espalda 27', '19.840.186-2');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (28, 'Rutina de pecho 28', '17.400.346-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (29, 'Rutina de hombros 29', '14.025.425-8');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (30, 'Rutina de brazos 30', '10.042.527-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (31, 'Rutina funcional 31', '20.304.637-5');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (32, 'Rutina de fuerza 32', '11.354.318-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (33, 'Rutina cardio HIIT 33', '11.857.850-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (34, 'Rutina de definición 34', '14.819.091-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (35, 'Rutina de resistencia 35', '23.702.981-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (36, 'Rutina de inicio 36', '11.645.033-K');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (37, 'Rutina avanzada 37', '17.543.956-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (38, 'Rutina de glúteos 38', '10.192.750-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (39, 'Rutina de torso 39', '23.669.449-6');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (40, 'Rutina de abdomen 40', '24.947.890-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (41, 'Rutina de hipertrofia 41', '21.495.380-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (42, 'Rutina Full Body A 42', '18.225.646-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (43, 'Rutina Full Body B 43', '21.398.255-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (44, 'Rutina Push Day 44', '15.271.957-4');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (45, 'Rutina Pull Day 45', '13.526.984-0');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (46, 'Rutina de piernas 46', '16.664.202-7');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (47, 'Rutina de espalda 47', '14.219.689-1');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (48, 'Rutina de pecho 48', '15.832.730-9');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (49, 'Rutina de hombros 49', '25.591.357-3');
INSERT INTO RUTINA (id_rutina, nombre_rutina, CLIENTE_rut_cliente) VALUES (50, 'Rutina de brazos 50', '15.983.360-7');

-- CONTENER: 50 registros
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (1, 2);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (2, 4);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (3, 6);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (4, 8);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (5, 10);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (6, 12);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (7, 14);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (8, 16);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (9, 18);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (10, 20);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (11, 22);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (12, 24);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (13, 26);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (14, 28);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (15, 30);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (16, 32);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (17, 34);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (18, 36);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (19, 38);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (20, 40);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (21, 42);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (22, 44);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (23, 46);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (24, 48);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (25, 50);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (26, 2);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (27, 4);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (28, 6);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (29, 8);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (30, 10);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (31, 12);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (32, 14);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (33, 16);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (34, 18);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (35, 20);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (36, 22);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (37, 24);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (38, 26);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (39, 28);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (40, 30);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (41, 32);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (42, 34);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (43, 36);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (44, 38);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (45, 40);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (46, 42);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (47, 44);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (48, 46);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (49, 48);
INSERT INTO CONTENER (RUTINA_id_rutina, EJERCICIO_id_ejercicio) VALUES (50, 50);

-- CONTRATO_CLI: 50 registros
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (1, TO_DATE('2026-08-28','YYYY-MM-DD'), TO_DATE('2026-09-28','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-28','YYYY-MM-DD'), TO_DATE('2026-09-28','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (2, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (3, TO_DATE('2026-03-26','YYYY-MM-DD'), TO_DATE('2026-06-26','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2026-03-26','YYYY-MM-DD'), TO_DATE('2026-06-26','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (4, TO_DATE('2026-07-22','YYYY-MM-DD'), TO_DATE('2026-10-22','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-22','YYYY-MM-DD'), TO_DATE('2026-10-22','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (5, TO_DATE('2026-07-17','YYYY-MM-DD'), TO_DATE('2027-01-17','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-07-17','YYYY-MM-DD'), TO_DATE('2027-01-17','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (6, TO_DATE('2024-11-03','YYYY-MM-DD'), TO_DATE('2025-11-03','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2024-11-03','YYYY-MM-DD'), TO_DATE('2025-11-03','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (7, TO_DATE('2026-02-14','YYYY-MM-DD'), TO_DATE('2027-02-14','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-02-14','YYYY-MM-DD'), TO_DATE('2027-02-14','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (8, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-11-22','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-11-22','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (9, TO_DATE('2026-07-24','YYYY-MM-DD'), TO_DATE('2026-08-24','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-07-24','YYYY-MM-DD'), TO_DATE('2026-08-24','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (10, TO_DATE('2026-09-02','YYYY-MM-DD'), TO_DATE('2026-10-02','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-02','YYYY-MM-DD'), TO_DATE('2026-10-02','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (11, TO_DATE('2026-09-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-10','YYYY-MM-DD'), TO_DATE('2026-10-10','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (12, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2026-08-26','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2026-08-26','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (13, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-11-04','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-11-04','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (14, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-11-30','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-11-30','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (15, TO_DATE('2025-11-07','YYYY-MM-DD'), TO_DATE('2026-05-07','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2025-11-07','YYYY-MM-DD'), TO_DATE('2026-05-07','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (16, TO_DATE('2026-04-09','YYYY-MM-DD'), TO_DATE('2027-04-09','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2026-04-09','YYYY-MM-DD'), TO_DATE('2027-04-09','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (17, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2027-07-26','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2027-07-26','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (18, TO_DATE('2026-04-18','YYYY-MM-DD'), TO_DATE('2026-07-18','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2026-04-18','YYYY-MM-DD'), TO_DATE('2026-07-18','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (19, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-09-06','YYYY-MM-DD'), TO_DATE('2026-10-06','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (20, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-21','YYYY-MM-DD'), TO_DATE('2026-09-21','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (21, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-08-30','YYYY-MM-DD'), 'Caducado', 2, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-08-30','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (22, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-09-08','YYYY-MM-DD'), TO_DATE('2026-10-08','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (23, TO_DATE('2026-06-29','YYYY-MM-DD'), TO_DATE('2026-09-29','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-06-29','YYYY-MM-DD'), TO_DATE('2026-09-29','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (24, TO_DATE('2026-04-27','YYYY-MM-DD'), TO_DATE('2026-07-27','YYYY-MM-DD'), 'Caducado', 5, TO_DATE('2026-04-27','YYYY-MM-DD'), TO_DATE('2026-07-27','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (25, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2027-01-26','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-07-26','YYYY-MM-DD'), TO_DATE('2027-01-26','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (26, TO_DATE('2025-11-16','YYYY-MM-DD'), TO_DATE('2026-11-16','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2025-11-16','YYYY-MM-DD'), TO_DATE('2026-11-16','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (27, TO_DATE('2025-03-09','YYYY-MM-DD'), TO_DATE('2026-03-09','YYYY-MM-DD'), 'Caducado', 8, TO_DATE('2025-03-09','YYYY-MM-DD'), TO_DATE('2026-03-09','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (28, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-11-27','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-11-27','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (29, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-25','YYYY-MM-DD'), TO_DATE('2026-09-25','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (30, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-09-04','YYYY-MM-DD'), 'Caducado', 1, TO_DATE('2026-08-04','YYYY-MM-DD'), TO_DATE('2026-09-04','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (31, TO_DATE('2026-09-12','YYYY-MM-DD'), TO_DATE('2026-10-12','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-09-12','YYYY-MM-DD'), TO_DATE('2026-10-12','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (32, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'), 'Vigente', 3, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (33, TO_DATE('2026-05-11','YYYY-MM-DD'), TO_DATE('2026-08-11','YYYY-MM-DD'), 'Caducado', 4, TO_DATE('2026-05-11','YYYY-MM-DD'), TO_DATE('2026-08-11','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (34, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (35, TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-11-15','YYYY-MM-DD'), 'Vigente', 6, TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-11-15','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (36, TO_DATE('2025-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'), 'Caducado', 7, TO_DATE('2025-05-02','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (37, TO_DATE('2025-10-11','YYYY-MM-DD'), TO_DATE('2026-10-11','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2025-10-11','YYYY-MM-DD'), TO_DATE('2026-10-11','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (38, TO_DATE('2026-07-22','YYYY-MM-DD'), TO_DATE('2026-10-22','YYYY-MM-DD'), 'Vigente', 9, TO_DATE('2026-07-22','YYYY-MM-DD'), TO_DATE('2026-10-22','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (39, TO_DATE('2026-08-09','YYYY-MM-DD'), TO_DATE('2026-09-09','YYYY-MM-DD'), 'Caducado', 10, TO_DATE('2026-08-09','YYYY-MM-DD'), TO_DATE('2026-09-09','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (40, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-09-22','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-08-22','YYYY-MM-DD'), TO_DATE('2026-09-22','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (41, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'), 'Vigente', 2, TO_DATE('2026-08-31','YYYY-MM-DD'), TO_DATE('2026-09-30','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (42, TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2026-09-10','YYYY-MM-DD'), 'Caducado', 3, TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2026-09-10','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (43, TO_DATE('2026-07-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), 'Vigente', 4, TO_DATE('2026-07-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (44, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-10-30','YYYY-MM-DD'), 'Vigente', 5, TO_DATE('2026-07-30','YYYY-MM-DD'), TO_DATE('2026-10-30','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (45, TO_DATE('2026-02-05','YYYY-MM-DD'), TO_DATE('2026-08-05','YYYY-MM-DD'), 'Caducado', 6, TO_DATE('2026-02-05','YYYY-MM-DD'), TO_DATE('2026-08-05','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (46, TO_DATE('2025-12-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'), 'Vigente', 7, TO_DATE('2025-12-04','YYYY-MM-DD'), TO_DATE('2026-12-04','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (47, TO_DATE('2026-03-22','YYYY-MM-DD'), TO_DATE('2027-03-22','YYYY-MM-DD'), 'Vigente', 8, TO_DATE('2026-03-22','YYYY-MM-DD'), TO_DATE('2027-03-22','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (48, TO_DATE('2026-06-02','YYYY-MM-DD'), TO_DATE('2026-09-02','YYYY-MM-DD'), 'Caducado', 9, TO_DATE('2026-06-02','YYYY-MM-DD'), TO_DATE('2026-09-02','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (49, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'), 'Vigente', 10, TO_DATE('2026-08-27','YYYY-MM-DD'), TO_DATE('2026-09-27','YYYY-MM-DD'));
INSERT INTO CONTRATO_CLI (id_contrato, fecha_inicio_contrato, fecha_termino_contrato, estado_contrato, PLAN_id_plan, fecha_ini, fecha_ter) VALUES (50, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'), 'Vigente', 1, TO_DATE('2026-09-04','YYYY-MM-DD'), TO_DATE('2026-10-04','YYYY-MM-DD'));

-- DEFINIR: 50 registros
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('23.507.938-0', 1);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.314.012-8', 2);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('22.515.298-5', 3);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.616.569-1', 4);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('20.699.123-2', 5);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('11.280.435-8', 6);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('22.131.805-6', 7);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('15.710.873-5', 8);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('11.504.328-5', 9);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.352.468-0', 10);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.027.228-1', 11);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('14.900.991-4', 12);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('14.825.159-2', 13);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.674.700-5', 14);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('12.363.714-3', 15);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.704.807-3', 16);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('20.817.865-2', 17);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('21.810.749-4', 18);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('22.019.455-8', 19);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.687.556-5', 20);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('15.184.138-4', 21);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('10.415.056-K', 22);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.223.627-0', 23);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('21.926.290-6', 24);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.188.185-6', 25);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.099.226-3', 26);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.735.513-5', 27);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.083.634-0', 28);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('11.521.428-4', 29);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.690.306-8', 30);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.947.974-8', 31);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.826.714-7', 32);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('19.302.111-5', 33);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.362.688-4', 34);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.549.625-7', 35);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('11.953.672-3', 36);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.137.754-4', 37);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.495.290-4', 38);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('23.464.542-0', 39);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('22.585.374-6', 40);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.541.731-4', 41);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('20.069.101-6', 42);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.687.336-4', 43);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.238.128-4', 44);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('16.679.821-3', 45);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('25.380.590-0', 46);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('18.802.211-1', 47);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('14.339.316-K', 48);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('24.167.984-5', 49);
INSERT INTO DEFINIR (PREPARADOR_FISICO_rut_prep, BLOQUE_HORARIO_id_bloque) VALUES ('17.045.862-1', 50);

-- DISENAR: 50 registros
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('23.507.938-0', 1);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.314.012-8', 2);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('22.515.298-5', 3);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.616.569-1', 4);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('20.699.123-2', 5);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('11.280.435-8', 6);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('22.131.805-6', 7);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('15.710.873-5', 8);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('11.504.328-5', 9);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.352.468-0', 10);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.027.228-1', 11);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('14.900.991-4', 12);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('14.825.159-2', 13);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.674.700-5', 14);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('12.363.714-3', 15);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.704.807-3', 16);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('20.817.865-2', 17);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('21.810.749-4', 18);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('22.019.455-8', 19);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.687.556-5', 20);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('15.184.138-4', 21);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('10.415.056-K', 22);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.223.627-0', 23);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('21.926.290-6', 24);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.188.185-6', 25);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.099.226-3', 26);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.735.513-5', 27);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.083.634-0', 28);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('11.521.428-4', 29);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.690.306-8', 30);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.947.974-8', 31);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.826.714-7', 32);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('19.302.111-5', 33);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.362.688-4', 34);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.549.625-7', 35);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('11.953.672-3', 36);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.137.754-4', 37);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.495.290-4', 38);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('23.464.542-0', 39);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('22.585.374-6', 40);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.541.731-4', 41);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('20.069.101-6', 42);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.687.336-4', 43);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.238.128-4', 44);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('16.679.821-3', 45);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('25.380.590-0', 46);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('18.802.211-1', 47);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('14.339.316-K', 48);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('24.167.984-5', 49);
INSERT INTO DISENAR (PREPARADOR_FISICO_rut_prep, RUTINA_id_rutina) VALUES ('17.045.862-1', 50);

-- EMPLEA: 50 registros
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('23.507.938-0', 4);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.314.012-8', 5);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('22.515.298-5', 6);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.616.569-1', 7);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('20.699.123-2', 8);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('11.280.435-8', 9);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('22.131.805-6', 10);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('15.710.873-5', 11);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('11.504.328-5', 12);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.352.468-0', 13);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.027.228-1', 14);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('14.900.991-4', 15);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('14.825.159-2', 16);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.674.700-5', 17);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('12.363.714-3', 18);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.704.807-3', 19);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('20.817.865-2', 20);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('21.810.749-4', 21);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('22.019.455-8', 22);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.687.556-5', 23);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('15.184.138-4', 24);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('10.415.056-K', 25);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.223.627-0', 26);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('21.926.290-6', 27);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.188.185-6', 28);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.099.226-3', 29);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.735.513-5', 30);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.083.634-0', 31);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('11.521.428-4', 32);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.690.306-8', 33);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.947.974-8', 34);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.826.714-7', 35);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('19.302.111-5', 36);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.362.688-4', 37);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.549.625-7', 38);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('11.953.672-3', 39);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.137.754-4', 40);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.495.290-4', 41);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('23.464.542-0', 42);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('22.585.374-6', 43);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.541.731-4', 44);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('20.069.101-6', 45);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.687.336-4', 46);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.238.128-4', 47);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('16.679.821-3', 48);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('25.380.590-0', 49);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('18.802.211-1', 50);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('14.339.316-K', 1);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('24.167.984-5', 2);
INSERT INTO EMPLEA (PREPARADOR_FISICO_rut_prep, CENTRO_DEPORTIVO_id_centro) VALUES ('17.045.862-1', 3);

-- METODO_PAGO_CLI: 5 registros
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (1, 'Efectivo', 'Pago en caja del gimnasio.');
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (2, 'Tarjeta de Débito', 'Pago con tarjeta de débito Redcompra.');
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (3, 'Tarjeta de Crédito', 'Pago con tarjeta de crédito Visa, Mastercard o American Express.');
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (4, 'Transferencia', 'Transferencia a la cuenta corriente del gimnasio.');
INSERT INTO METODO_PAGO_CLI (id_metodo_pago, nombre_metodo_pago, descripcion_metodo_pago) VALUES (5, 'Pago QR', 'Pago escaneando el código QR del gimnasio desde la app.');

-- PAGO: 50 registros
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (1, 24990, TO_DATE('2026-08-31','YYYY-MM-DD'), 'Pagado', 1, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (2, 29990, TO_DATE('2026-09-10','YYYY-MM-DD'), 'Pagado', 2, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (3, 34990, TO_DATE('2026-03-31','YYYY-MM-DD'), 'Pagado', 3, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (4, 39990, TO_DATE('2026-07-28','YYYY-MM-DD'), 'Pagado', 4, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (5, 49990, TO_DATE('2026-07-24','YYYY-MM-DD'), 'Pagado', 5, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (6, 59990, TO_DATE('2024-11-11','YYYY-MM-DD'), 'Pagado', 6, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (7, 79990, TO_DATE('2026-02-16','YYYY-MM-DD'), 'Pagado', 7, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (8, 44990, TO_DATE('2026-08-25','YYYY-MM-DD'), 'Pagado', 8, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (9, 17990, TO_DATE('2026-07-28','YYYY-MM-DD'), 'Pagado', 9, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (10, 19990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 10, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (11, 24990, TO_DATE('2026-09-16','YYYY-MM-DD'), 'Pagado', 11, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (12, 29990, TO_DATE('2026-08-02','YYYY-MM-DD'), 'Pagado', 12, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (13, 34990, TO_DATE('2026-08-12','YYYY-MM-DD'), 'Pagado', 13, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (14, 39990, TO_DATE('2026-09-02','YYYY-MM-DD'), 'Pagado', 14, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (15, 49990, TO_DATE('2025-11-10','YYYY-MM-DD'), 'Pagado', 15, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (16, 59990, TO_DATE('2026-04-13','YYYY-MM-DD'), 'Pagado', 16, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (17, 79990, TO_DATE('2026-07-31','YYYY-MM-DD'), 'Pagado', 17, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (18, 44990, TO_DATE('2026-04-24','YYYY-MM-DD'), 'Pagado', 18, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (19, 17990, TO_DATE('2026-09-13','YYYY-MM-DD'), 'Pagado', 19, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (20, 19990, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Pagado', 20, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (21, 24990, TO_DATE('2026-08-01','YYYY-MM-DD'), 'Pagado', 21, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (22, 29990, TO_DATE('2026-09-11','YYYY-MM-DD'), 'Pagado', 22, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (23, 34990, TO_DATE('2026-07-03','YYYY-MM-DD'), 'Pagado', 23, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (24, 39990, TO_DATE('2026-05-02','YYYY-MM-DD'), 'Pagado', 24, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (25, 49990, TO_DATE('2026-08-01','YYYY-MM-DD'), 'Pagado', 25, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (26, 59990, TO_DATE('2025-11-23','YYYY-MM-DD'), 'Pagado', 26, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (27, 79990, TO_DATE('2025-03-17','YYYY-MM-DD'), 'Pagado', 27, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (28, 44990, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Pagado', 28, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (29, 17990, TO_DATE('2026-08-28','YYYY-MM-DD'), 'Pagado', 29, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (30, 19990, TO_DATE('2026-08-08','YYYY-MM-DD'), 'Pagado', 30, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (31, 24990, TO_DATE('2026-09-17','YYYY-MM-DD'), 'Pagado', 31, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (32, 29990, TO_DATE('2026-09-02','YYYY-MM-DD'), 'Pagado', 32, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (33, 34990, TO_DATE('2026-05-18','YYYY-MM-DD'), 'Pagado', 33, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (34, 39990, TO_DATE('2026-09-12','YYYY-MM-DD'), 'Pagado', 34, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (35, 49990, TO_DATE('2026-05-17','YYYY-MM-DD'), 'Pagado', 35, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (36, 59990, TO_DATE('2025-05-05','YYYY-MM-DD'), 'Pagado', 36, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (37, 79990, TO_DATE('2025-10-15','YYYY-MM-DD'), 'Pagado', 37, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (38, 44990, TO_DATE('2026-07-27','YYYY-MM-DD'), 'Pagado', 38, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (39, 17990, TO_DATE('2026-08-15','YYYY-MM-DD'), 'Pagado', 39, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (40, 19990, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Pagado', 40, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (41, 24990, TO_DATE('2026-09-08','YYYY-MM-DD'), 'Pagado', 41, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (42, 29990, TO_DATE('2026-08-12','YYYY-MM-DD'), 'Pagado', 42, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (43, 34990, TO_DATE('2026-07-07','YYYY-MM-DD'), 'Pagado', 43, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (44, 39990, TO_DATE('2026-08-03','YYYY-MM-DD'), 'Pagado', 44, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (45, 49990, TO_DATE('2026-02-10','YYYY-MM-DD'), 'Pagado', 45, 1);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (46, 59990, TO_DATE('2025-12-10','YYYY-MM-DD'), 'Pagado', 46, 2);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (47, 79990, TO_DATE('2026-03-29','YYYY-MM-DD'), 'Pagado', 47, 3);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (48, 44990, TO_DATE('2026-06-10','YYYY-MM-DD'), 'Pagado', 48, 4);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (49, 17990, TO_DATE('2026-08-29','YYYY-MM-DD'), 'Pagado', 49, 5);
INSERT INTO PAGO (id_pago, monto_pago, fecha_pago, estado_pago, CONTRATO_CLI_id_contrato, METODO_PAGO_CLI_id_metodo_pago) VALUES (50, 19990, TO_DATE('2026-09-07','YYYY-MM-DD'), 'Pagado', 50, 1);

-- FACTURA: 50 registros
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (1, TO_DATE('2026-08-31','YYYY-MM-DD'), 24990, 1);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (2, TO_DATE('2026-09-10','YYYY-MM-DD'), 29990, 2);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (3, TO_DATE('2026-03-31','YYYY-MM-DD'), 34990, 3);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (4, TO_DATE('2026-07-28','YYYY-MM-DD'), 39990, 4);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (5, TO_DATE('2026-07-24','YYYY-MM-DD'), 49990, 5);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (6, TO_DATE('2024-11-11','YYYY-MM-DD'), 59990, 6);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (7, TO_DATE('2026-02-16','YYYY-MM-DD'), 79990, 7);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (8, TO_DATE('2026-08-25','YYYY-MM-DD'), 44990, 8);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (9, TO_DATE('2026-07-28','YYYY-MM-DD'), 17990, 9);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (10, TO_DATE('2026-09-07','YYYY-MM-DD'), 19990, 10);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (11, TO_DATE('2026-09-16','YYYY-MM-DD'), 24990, 11);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (12, TO_DATE('2026-08-02','YYYY-MM-DD'), 29990, 12);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (13, TO_DATE('2026-08-12','YYYY-MM-DD'), 34990, 13);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (14, TO_DATE('2026-09-02','YYYY-MM-DD'), 39990, 14);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (15, TO_DATE('2025-11-10','YYYY-MM-DD'), 49990, 15);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (16, TO_DATE('2026-04-13','YYYY-MM-DD'), 59990, 16);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (17, TO_DATE('2026-07-31','YYYY-MM-DD'), 79990, 17);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (18, TO_DATE('2026-04-24','YYYY-MM-DD'), 44990, 18);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (19, TO_DATE('2026-09-13','YYYY-MM-DD'), 17990, 19);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (20, TO_DATE('2026-08-29','YYYY-MM-DD'), 19990, 20);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (21, TO_DATE('2026-08-01','YYYY-MM-DD'), 24990, 21);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (22, TO_DATE('2026-09-11','YYYY-MM-DD'), 29990, 22);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (23, TO_DATE('2026-07-03','YYYY-MM-DD'), 34990, 23);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (24, TO_DATE('2026-05-02','YYYY-MM-DD'), 39990, 24);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (25, TO_DATE('2026-08-01','YYYY-MM-DD'), 49990, 25);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (26, TO_DATE('2025-11-23','YYYY-MM-DD'), 59990, 26);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (27, TO_DATE('2025-03-17','YYYY-MM-DD'), 79990, 27);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (28, TO_DATE('2026-08-29','YYYY-MM-DD'), 44990, 28);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (29, TO_DATE('2026-08-28','YYYY-MM-DD'), 17990, 29);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (30, TO_DATE('2026-08-08','YYYY-MM-DD'), 19990, 30);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (31, TO_DATE('2026-09-17','YYYY-MM-DD'), 24990, 31);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (32, TO_DATE('2026-09-02','YYYY-MM-DD'), 29990, 32);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (33, TO_DATE('2026-05-18','YYYY-MM-DD'), 34990, 33);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (34, TO_DATE('2026-09-12','YYYY-MM-DD'), 39990, 34);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (35, TO_DATE('2026-05-17','YYYY-MM-DD'), 49990, 35);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (36, TO_DATE('2025-05-05','YYYY-MM-DD'), 59990, 36);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (37, TO_DATE('2025-10-15','YYYY-MM-DD'), 79990, 37);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (38, TO_DATE('2026-07-27','YYYY-MM-DD'), 44990, 38);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (39, TO_DATE('2026-08-15','YYYY-MM-DD'), 17990, 39);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (40, TO_DATE('2026-08-29','YYYY-MM-DD'), 19990, 40);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (41, TO_DATE('2026-09-08','YYYY-MM-DD'), 24990, 41);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (42, TO_DATE('2026-08-12','YYYY-MM-DD'), 29990, 42);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (43, TO_DATE('2026-07-07','YYYY-MM-DD'), 34990, 43);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (44, TO_DATE('2026-08-03','YYYY-MM-DD'), 39990, 44);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (45, TO_DATE('2026-02-10','YYYY-MM-DD'), 49990, 45);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (46, TO_DATE('2025-12-10','YYYY-MM-DD'), 59990, 46);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (47, TO_DATE('2026-03-29','YYYY-MM-DD'), 79990, 47);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (48, TO_DATE('2026-06-10','YYYY-MM-DD'), 44990, 48);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (49, TO_DATE('2026-08-29','YYYY-MM-DD'), 17990, 49);
INSERT INTO FACTURA (id_factura, fecha_emision, total_factura, PAGO_id_pago) VALUES (50, TO_DATE('2026-09-07','YYYY-MM-DD'), 19990, 50);

-- FICHA_CLIENTE: 50 registros
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (1, TO_DATE('2025-07-24','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-07-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (2, TO_DATE('2025-04-24','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-04-24','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (3, TO_DATE('2025-07-01','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-07-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (4, TO_DATE('2025-06-16','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-06-16','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (5, TO_DATE('2025-05-22','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-05-22','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (6, TO_DATE('2025-02-17','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-02-17','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (7, TO_DATE('2025-02-13','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-02-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (8, TO_DATE('2025-06-23','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-06-23','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (9, TO_DATE('2025-08-08','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-08-08','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (10, TO_DATE('2025-09-15','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-09-15','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (11, TO_DATE('2025-09-04','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-09-04','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (12, TO_DATE('2025-01-08','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-01-08','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (13, TO_DATE('2025-11-26','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-11-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (14, TO_DATE('2025-01-28','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-01-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (15, TO_DATE('2025-05-03','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-05-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (16, TO_DATE('2025-01-01','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-01-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (17, TO_DATE('2025-11-21','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-11-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (18, TO_DATE('2025-12-05','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-12-05','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (19, TO_DATE('2025-06-03','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-06-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (20, TO_DATE('2025-12-18','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-12-18','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (21, TO_DATE('2025-09-22','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-09-22','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (22, TO_DATE('2025-11-21','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-11-21','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (23, TO_DATE('2025-05-09','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-05-09','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (24, TO_DATE('2025-12-25','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-12-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (25, TO_DATE('2025-09-10','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-09-10','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (26, TO_DATE('2025-05-06','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-05-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (27, TO_DATE('2025-09-10','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-09-10','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (28, TO_DATE('2025-06-27','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-06-27','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (29, TO_DATE('2025-10-13','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-10-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (30, TO_DATE('2025-04-12','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-04-12','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (31, TO_DATE('2025-04-11','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-04-11','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (32, TO_DATE('2025-09-28','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-09-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (33, TO_DATE('2025-07-25','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-07-25','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (34, TO_DATE('2025-07-06','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-07-06','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (35, TO_DATE('2025-05-09','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-05-09','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (36, TO_DATE('2025-10-28','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-10-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (37, TO_DATE('2025-12-28','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-12-28','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (38, TO_DATE('2025-04-01','YYYY-MM-DD'), 'Evaluación inicial completada', TO_DATE('2025-04-01','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (39, TO_DATE('2025-07-22','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-07-22','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (40, TO_DATE('2025-12-12','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-12-12','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (41, TO_DATE('2025-06-14','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-06-14','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (42, TO_DATE('2025-10-18','YYYY-MM-DD'), 'Derivado a nutricionista', TO_DATE('2025-10-18','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (43, TO_DATE('2025-02-26','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-02-26','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (44, TO_DATE('2025-07-12','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-07-12','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (45, TO_DATE('2025-12-02','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-12-02','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (46, TO_DATE('2025-07-07','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-07-07','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (47, TO_DATE('2025-07-03','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-07-03','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (48, TO_DATE('2025-09-18','YYYY-MM-DD'), 'Ingreso al programa de entrenamiento', TO_DATE('2025-09-18','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (49, TO_DATE('2025-02-13','YYYY-MM-DD'), 'Sin observaciones relevantes', TO_DATE('2025-02-13','YYYY-MM-DD'));
INSERT INTO FICHA_CLIENTE (id_ficha, fecha_creacion, observaciones, fecha_observacion) VALUES (50, TO_DATE('2025-05-26','YYYY-MM-DD'), 'Requiere control de presión arterial', TO_DATE('2025-05-26','YYYY-MM-DD'));

-- METRICAS_CLIENTE: 50 registros
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (1, 87.97, 176.00, 97.44, 82.03, 95.51, 121.72, 35.83, 56.67, 40.91, TO_DATE('2025-07-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (2, 54.05, 152.00, 99.16, 79.42, 86.80, 93.48, 36.98, 51.41, 41.53, TO_DATE('2025-04-24','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (3, 113.55, 187.00, 115.76, 94.53, 103.45, 110.89, 28.13, 57.38, 40.98, TO_DATE('2025-07-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (4, 53.76, 154.00, 87.34, 72.05, 83.11, 98.30, 28.68, 60.57, 38.04, TO_DATE('2025-06-16','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (5, 88.05, 175.00, 113.47, 87.66, 94.45, 116.73, 31.87, 48.67, 38.31, TO_DATE('2025-05-22','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (6, 69.75, 161.00, 97.49, 78.10, 87.93, 100.05, 28.31, 64.17, 34.21, TO_DATE('2025-02-17','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (7, 73.41, 195.00, 92.47, 75.20, 87.22, 127.30, 35.29, 61.18, 40.71, TO_DATE('2025-02-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (8, 60.75, 163.00, 89.73, 87.11, 96.31, 105.19, 35.20, 63.27, 36.77, TO_DATE('2025-06-23','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (9, 74.21, 169.00, 94.96, 86.38, 96.62, 113.16, 34.99, 51.93, 39.57, TO_DATE('2025-08-08','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (10, 60.31, 174.00, 89.53, 83.48, 94.12, 109.00, 32.95, 63.65, 34.50, TO_DATE('2025-09-15','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (11, 83.42, 170.00, 93.98, 78.42, 85.31, 113.73, 29.48, 65.82, 36.61, TO_DATE('2025-09-04','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (12, 51.79, 171.00, 86.06, 69.46, 77.50, 98.23, 41.11, 48.65, 39.36, TO_DATE('2025-01-08','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (13, 70.78, 179.00, 109.34, 83.25, 96.94, 125.18, 34.54, 65.09, 38.67, TO_DATE('2025-11-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (14, 72.77, 177.00, 83.13, 64.55, 72.78, 104.34, 28.10, 59.12, 33.39, TO_DATE('2025-01-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (15, 73.38, 186.00, 107.18, 80.19, 90.52, 123.69, 31.20, 55.07, 33.79, TO_DATE('2025-05-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (16, 63.50, 153.00, 98.20, 67.00, 77.47, 95.21, 35.07, 54.07, 35.51, TO_DATE('2025-01-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (17, 88.41, 163.00, 93.93, 93.57, 104.11, 127.54, 35.24, 52.38, 40.36, TO_DATE('2025-11-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (18, 56.15, 165.00, 85.33, 84.80, 96.38, 91.97, 36.81, 60.08, 36.05, TO_DATE('2025-12-05','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (19, 66.05, 172.00, 95.01, 94.01, 107.58, 126.64, 36.07, 65.89, 34.62, TO_DATE('2025-06-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (20, 84.04, 160.00, 99.67, 82.00, 89.94, 102.98, 34.60, 64.95, 38.47, TO_DATE('2025-12-18','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (21, 70.66, 167.00, 107.94, 82.09, 90.11, 113.79, 34.22, 53.32, 34.36, TO_DATE('2025-09-22','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (22, 65.54, 153.00, 87.46, 71.09, 83.86, 107.81, 41.35, 55.90, 37.00, TO_DATE('2025-11-21','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (23, 101.98, 178.00, 99.71, 82.14, 93.04, 108.04, 28.43, 51.84, 39.29, TO_DATE('2025-05-09','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (24, 57.87, 169.00, 89.81, 84.40, 91.43, 95.06, 32.69, 57.66, 34.87, TO_DATE('2025-12-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (25, 91.91, 176.00, 98.86, 96.51, 103.92, 114.85, 32.23, 61.23, 40.42, TO_DATE('2025-09-10','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (26, 73.45, 154.00, 105.68, 79.82, 90.71, 104.98, 38.33, 62.39, 37.62, TO_DATE('2025-05-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (27, 76.29, 188.00, 114.93, 96.93, 107.02, 126.74, 39.21, 62.96, 38.53, TO_DATE('2025-09-10','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (28, 76.29, 165.00, 82.32, 76.72, 89.86, 98.52, 33.10, 65.01, 35.20, TO_DATE('2025-06-27','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (29, 108.18, 195.00, 92.76, 80.14, 91.08, 108.20, 34.62, 62.65, 36.92, TO_DATE('2025-10-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (30, 69.09, 177.00, 84.81, 73.13, 81.91, 100.06, 35.22, 63.87, 33.89, TO_DATE('2025-04-12','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (31, 109.87, 166.00, 93.72, 82.89, 93.91, 107.62, 29.39, 49.90, 40.37, TO_DATE('2025-04-11','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (32, 61.93, 155.00, 84.08, 68.63, 82.23, 99.75, 40.82, 64.53, 37.96, TO_DATE('2025-09-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (33, 69.56, 188.00, 103.00, 99.78, 106.27, 114.60, 34.66, 61.45, 41.98, TO_DATE('2025-07-25','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (34, 72.41, 157.00, 95.08, 68.95, 82.56, 92.40, 28.15, 50.55, 38.46, TO_DATE('2025-07-06','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (35, 104.29, 188.00, 101.49, 93.56, 104.63, 113.85, 36.09, 59.12, 35.87, TO_DATE('2025-05-09','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (36, 60.88, 171.00, 96.52, 67.08, 73.35, 99.22, 36.53, 57.49, 35.61, TO_DATE('2025-10-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (37, 75.40, 197.00, 110.92, 85.49, 95.63, 112.59, 41.34, 53.60, 40.85, TO_DATE('2025-12-28','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (38, 71.03, 159.00, 89.64, 87.79, 99.08, 104.03, 33.68, 55.64, 37.16, TO_DATE('2025-04-01','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (39, 113.78, 195.00, 117.81, 93.65, 102.25, 114.87, 33.28, 48.26, 36.21, TO_DATE('2025-07-22','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (40, 77.38, 150.00, 91.92, 63.23, 74.90, 90.51, 35.57, 57.80, 33.49, TO_DATE('2025-12-12','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (41, 84.20, 197.00, 116.77, 80.69, 87.15, 108.95, 31.20, 48.90, 36.30, TO_DATE('2025-06-14','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (42, 53.61, 167.00, 94.39, 79.29, 86.15, 96.36, 33.86, 50.10, 41.98, TO_DATE('2025-10-18','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (43, 114.94, 195.00, 110.74, 74.96, 87.63, 114.58, 38.30, 61.62, 40.76, TO_DATE('2025-02-26','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (44, 73.67, 172.00, 86.56, 63.43, 71.57, 96.86, 41.03, 57.65, 38.46, TO_DATE('2025-07-12','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (45, 87.67, 184.00, 113.35, 85.47, 97.75, 119.26, 32.02, 62.06, 40.17, TO_DATE('2025-12-02','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (46, 83.72, 163.00, 96.91, 67.76, 80.17, 93.50, 32.13, 63.96, 34.74, TO_DATE('2025-07-07','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (47, 84.55, 165.00, 117.85, 83.54, 91.75, 120.08, 31.06, 54.12, 33.84, TO_DATE('2025-07-03','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (48, 78.84, 152.00, 87.40, 77.63, 90.59, 107.30, 30.39, 51.50, 35.27, TO_DATE('2025-09-18','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (49, 94.40, 180.00, 96.97, 93.76, 103.55, 126.51, 40.73, 58.71, 38.61, TO_DATE('2025-02-13','YYYY-MM-DD'));
INSERT INTO METRICAS_CLIENTE (id_metrica, peso_cliente, estatura_cliente, medida_pecho_cliente, medida_cintura_cliente, medida_cadera_cliente, medida_hombros_cliente, medida_brazos_cliente, medida_muslos_cliente, medidas_pantorillas_cliente, fecha_medicion_cliente) VALUES (50, 51.72, 166.00, 102.34, 68.34, 79.42, 96.07, 28.48, 53.50, 35.41, TO_DATE('2025-05-26','YYYY-MM-DD'));

-- OFRECER: 50 registros
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('23.507.938-0', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.314.012-8', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('22.515.298-5', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.616.569-1', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('20.699.123-2', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('11.280.435-8', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('22.131.805-6', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('15.710.873-5', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('11.504.328-5', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.352.468-0', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.027.228-1', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('14.900.991-4', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('14.825.159-2', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.674.700-5', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('12.363.714-3', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.704.807-3', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('20.817.865-2', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('21.810.749-4', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('22.019.455-8', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.687.556-5', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('15.184.138-4', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('10.415.056-K', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.223.627-0', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('21.926.290-6', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.188.185-6', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.099.226-3', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.735.513-5', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.083.634-0', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('11.521.428-4', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.690.306-8', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.947.974-8', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.826.714-7', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('19.302.111-5', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.362.688-4', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.549.625-7', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('11.953.672-3', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.137.754-4', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.495.290-4', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('23.464.542-0', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('22.585.374-6', 10);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.541.731-4', 1);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('20.069.101-6', 2);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.687.336-4', 3);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.238.128-4', 4);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('16.679.821-3', 5);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('25.380.590-0', 6);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('18.802.211-1', 7);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('14.339.316-K', 8);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('24.167.984-5', 9);
INSERT INTO OFRECER (PREPARADOR_FISICO_rut_prep, PLAN_id_plan) VALUES ('17.045.862-1', 10);

-- PATOLOGIAS: 70 registros
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (1, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 1, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (2, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 2, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (3, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 3, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (4, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 4, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (5, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 5, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (6, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 6, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (7, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 7, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (8, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 8, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (9, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 9, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (10, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 10, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (11, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 11, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (12, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 12, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (13, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 13, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (14, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 14, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (15, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 15, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (16, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 16, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (17, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 17, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (18, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 18, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (19, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 19, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (20, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 20, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (21, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 21, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (22, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 22, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (23, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 23, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (24, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 24, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (25, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 25, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (26, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 26, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (27, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 27, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (28, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 28, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (29, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 29, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (30, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 30, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (31, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 1, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (32, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 2, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (33, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 3, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (34, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 4, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (35, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 5, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (36, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 6, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (37, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 7, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (38, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 8, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (39, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 9, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (40, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 10, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (41, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 11, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (42, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 12, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (43, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 13, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (44, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 14, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (45, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 15, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (46, 'Asma bronquial', 'Respiratoria', 'Moderado', 'Crónica', 16, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (47, 'Escoliosis leve', 'Osteoarticular', 'Leve', 'Permanente', 17, 4);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (48, 'Reflujo gastroesofágico', 'Digestiva', 'Leve', 'Crónica', 18, 7);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (49, 'Artritis reumatoide', 'Autoinmune', 'Moderado', 'Crónica', 19, 8);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (50, 'Bronquitis crónica', 'Respiratoria', 'Leve', 'Crónica', 20, 2);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (51, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 31, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (52, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 32, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (53, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 33, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (54, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 34, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (55, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 35, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (56, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 36, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (57, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 37, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (58, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 38, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (59, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 39, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (60, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 40, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (61, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 41, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (62, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 42, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (63, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 43, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (64, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 44, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (65, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 45, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (66, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 46, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (67, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 47, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (68, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 48, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (69, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 49, 51);
INSERT INTO PATOLOGIAS (id_patologia, nombre_patologia, tipo_patologia, grado_patologia, duracion_patologia, FICHA_CLIENTE_id_ficha, CAT_PATOLOGIA_id_cat) VALUES (70, 'Sin Patologías', 'Ninguna', 'Ninguno', 'N/A', 50, 51);

-- PROGRE_CLI: 50 registros
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (1, 'Logró bajar 2 kg en el primer mes', TO_DATE('2025-07-24','YYYY-MM-DD'), 1);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (2, 'Aumentó su masa muscular visiblemente', TO_DATE('2025-04-24','YYYY-MM-DD'), 2);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (3, 'Mejoró su resistencia cardiovascular', TO_DATE('2026-09-08','YYYY-MM-DD'), 3);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (4, 'Completó el plan de definición', TO_DATE('2025-07-13','YYYY-MM-DD'), 4);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (5, 'Aumentó su carga de trabajo en sentadilla', TO_DATE('2025-08-11','YYYY-MM-DD'), 5);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (6, 'Redujo su porcentaje de grasa corporal', TO_DATE('2025-04-03','YYYY-MM-DD'), 6);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (7, 'Mejoró su postura y movilidad', TO_DATE('2026-06-03','YYYY-MM-DD'), 7);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (8, 'Logró su primera dominada', TO_DATE('2025-08-07','YYYY-MM-DD'), 8);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (9, 'Incrementó su flexibilidad notablemente', TO_DATE('2025-08-18','YYYY-MM-DD'), 9);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (10, 'Mantuvo constancia en la asistencia', TO_DATE('2025-09-15','YYYY-MM-DD'), 10);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (11, 'Logró bajar 2 kg en el primer mes', TO_DATE('2025-10-14','YYYY-MM-DD'), 11);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (12, 'Aumentó su masa muscular visiblemente', TO_DATE('2025-03-02','YYYY-MM-DD'), 12);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (13, 'Mejoró su resistencia cardiovascular', TO_DATE('2026-07-19','YYYY-MM-DD'), 13);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (14, 'Completó el plan de definición', TO_DATE('2026-04-24','YYYY-MM-DD'), 14);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (15, 'Aumentó su carga de trabajo en sentadilla', TO_DATE('2026-02-04','YYYY-MM-DD'), 15);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (16, 'Redujo su porcentaje de grasa corporal', TO_DATE('2025-01-25','YYYY-MM-DD'), 16);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (17, 'Mejoró su postura y movilidad', TO_DATE('2026-07-22','YYYY-MM-DD'), 17);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (18, 'Logró su primera dominada', TO_DATE('2025-12-05','YYYY-MM-DD'), 18);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (19, 'Incrementó su flexibilidad notablemente', TO_DATE('2025-06-03','YYYY-MM-DD'), 19);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (20, 'Mantuvo constancia en la asistencia', TO_DATE('2025-12-18','YYYY-MM-DD'), 20);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (21, 'Logró bajar 2 kg en el primer mes', TO_DATE('2025-11-26','YYYY-MM-DD'), 21);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (22, 'Aumentó su masa muscular visiblemente', TO_DATE('2026-01-05','YYYY-MM-DD'), 22);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (23, 'Mejoró su resistencia cardiovascular', TO_DATE('2026-05-06','YYYY-MM-DD'), 23);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (24, 'Completó el plan de definición', TO_DATE('2026-09-05','YYYY-MM-DD'), 24);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (25, 'Aumentó su carga de trabajo en sentadilla', TO_DATE('2025-12-13','YYYY-MM-DD'), 25);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (26, 'Redujo su porcentaje de grasa corporal', TO_DATE('2025-05-28','YYYY-MM-DD'), 26);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (27, 'Mejoró su postura y movilidad', TO_DATE('2026-04-03','YYYY-MM-DD'), 27);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (28, 'Logró su primera dominada', TO_DATE('2026-08-09','YYYY-MM-DD'), 28);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (29, 'Incrementó su flexibilidad notablemente', TO_DATE('2026-07-09','YYYY-MM-DD'), 29);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (30, 'Mantuvo constancia en la asistencia', TO_DATE('2025-04-12','YYYY-MM-DD'), 30);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (31, 'Logró bajar 2 kg en el primer mes', TO_DATE('2025-04-11','YYYY-MM-DD'), 31);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (32, 'Aumentó su masa muscular visiblemente', TO_DATE('2026-08-15','YYYY-MM-DD'), 32);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (33, 'Mejoró su resistencia cardiovascular', TO_DATE('2025-07-25','YYYY-MM-DD'), 33);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (34, 'Completó el plan de definición', TO_DATE('2025-12-12','YYYY-MM-DD'), 34);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (35, 'Aumentó su carga de trabajo en sentadilla', TO_DATE('2025-05-10','YYYY-MM-DD'), 35);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (36, 'Redujo su porcentaje de grasa corporal', TO_DATE('2025-12-12','YYYY-MM-DD'), 36);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (37, 'Mejoró su postura y movilidad', TO_DATE('2026-08-05','YYYY-MM-DD'), 37);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (38, 'Logró su primera dominada', TO_DATE('2026-03-03','YYYY-MM-DD'), 38);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (39, 'Incrementó su flexibilidad notablemente', TO_DATE('2025-07-22','YYYY-MM-DD'), 39);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (40, 'Mantuvo constancia en la asistencia', TO_DATE('2025-12-12','YYYY-MM-DD'), 40);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (41, 'Logró bajar 2 kg en el primer mes', TO_DATE('2025-07-29','YYYY-MM-DD'), 41);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (42, 'Aumentó su masa muscular visiblemente', TO_DATE('2025-12-02','YYYY-MM-DD'), 42);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (43, 'Mejoró su resistencia cardiovascular', TO_DATE('2025-08-27','YYYY-MM-DD'), 43);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (44, 'Completó el plan de definición', TO_DATE('2025-07-12','YYYY-MM-DD'), 44);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (45, 'Aumentó su carga de trabajo en sentadilla', TO_DATE('2025-12-02','YYYY-MM-DD'), 45);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (46, 'Redujo su porcentaje de grasa corporal', TO_DATE('2025-08-21','YYYY-MM-DD'), 46);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (47, 'Mejoró su postura y movilidad', TO_DATE('2025-07-03','YYYY-MM-DD'), 47);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (48, 'Logró su primera dominada', TO_DATE('2025-11-05','YYYY-MM-DD'), 48);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (49, 'Incrementó su flexibilidad notablemente', TO_DATE('2026-03-20','YYYY-MM-DD'), 49);
INSERT INTO PROGRE_CLI (id_progreso, descripcion_progreso, fecha_progreso, FICHA_CLIENTE_id_ficha) VALUES (50, 'Mantuvo constancia en la asistencia', TO_DATE('2025-05-26','YYYY-MM-DD'), 50);

-- REGISTRAR: 50 registros
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (1, 1);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (2, 2);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (3, 3);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (4, 4);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (5, 5);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (6, 6);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (7, 7);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (8, 8);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (9, 9);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (10, 10);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (11, 11);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (12, 12);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (13, 13);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (14, 14);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (15, 15);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (16, 16);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (17, 17);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (18, 18);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (19, 19);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (20, 20);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (21, 21);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (22, 22);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (23, 23);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (24, 24);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (25, 25);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (26, 26);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (27, 27);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (28, 28);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (29, 29);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (30, 30);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (31, 31);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (32, 32);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (33, 33);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (34, 34);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (35, 35);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (36, 36);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (37, 37);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (38, 38);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (39, 39);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (40, 40);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (41, 41);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (42, 42);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (43, 43);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (44, 44);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (45, 45);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (46, 46);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (47, 47);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (48, 48);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (49, 49);
INSERT INTO REGISTRAR (METRICAS_CLIENTE_id_metrica, FICHA_CLIENTE_id_ficha) VALUES (50, 50);

-- SESION_ENTRENAMIENTO: 50 registros
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (1, TO_DATE('2025-09-28','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 2, 2, TO_DATE('2025-09-28','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (2, TO_DATE('2026-04-09','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 4, 4, TO_DATE('2026-04-09','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (3, TO_DATE('2026-01-22','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 5, 5, TO_DATE('2026-01-22','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (4, TO_DATE('2026-08-09','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 7, 7, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (5, TO_DATE('2026-08-28','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 8, 8, TO_DATE('2026-08-28','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (6, TO_DATE('2025-09-05','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 9, 9, TO_DATE('2025-09-05','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (7, TO_DATE('2025-03-13','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 11, 11, TO_DATE('2025-03-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (8, TO_DATE('2026-08-26','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 13, 13, TO_DATE('2026-08-26','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (9, TO_DATE('2025-12-18','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 14, 14, TO_DATE('2025-12-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (10, TO_DATE('2025-12-02','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 16, 16, TO_DATE('2025-12-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (11, TO_DATE('2026-08-27','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 17, 17, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (12, TO_DATE('2025-01-16','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 18, 18, TO_DATE('2025-01-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (13, TO_DATE('2025-01-19','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 19, 19, TO_DATE('2025-01-19','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (14, TO_DATE('2025-04-25','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 21, 21, TO_DATE('2025-04-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (15, TO_DATE('2025-08-07','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 22, 22, TO_DATE('2025-08-07','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (16, TO_DATE('2025-01-12','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 23, 23, TO_DATE('2025-01-12','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (17, TO_DATE('2026-01-07','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 24, 24, TO_DATE('2026-01-07','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (18, TO_DATE('2025-05-17','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 25, 25, TO_DATE('2025-05-17','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (19, TO_DATE('2026-08-23','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 26, 26, TO_DATE('2026-08-23','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (20, TO_DATE('2025-07-23','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 27, 27, TO_DATE('2025-07-23','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (21, TO_DATE('2026-02-04','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 28, 28, TO_DATE('2026-02-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (22, TO_DATE('2026-07-08','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 29, 29, TO_DATE('2026-07-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (23, TO_DATE('2025-03-01','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 31, 31, TO_DATE('2025-03-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (24, TO_DATE('2025-09-08','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 32, 32, TO_DATE('2025-09-08','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (25, TO_DATE('2025-01-28','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 33, 33, TO_DATE('2025-01-28','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (26, TO_DATE('2025-01-01','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 35, 35, TO_DATE('2025-01-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (27, TO_DATE('2026-03-13','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 36, 36, TO_DATE('2026-03-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (28, TO_DATE('2026-08-04','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 38, 38, TO_DATE('2026-08-04','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (29, TO_DATE('2026-06-06','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 39, 39, TO_DATE('2026-06-06','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (30, TO_DATE('2025-07-15','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 41, 41, TO_DATE('2025-07-15','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (31, TO_DATE('2025-03-25','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 43, 43, TO_DATE('2025-03-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (32, TO_DATE('2026-08-01','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 44, 44, TO_DATE('2026-08-01','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (33, TO_DATE('2026-08-20','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 45, 45, TO_DATE('2026-08-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (34, TO_DATE('2025-04-20','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 47, 47, TO_DATE('2025-04-20','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (35, TO_DATE('2025-08-22','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 50, 50, TO_DATE('2025-08-22','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (36, TO_DATE('2025-09-28','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 2, 2, TO_DATE('2025-09-28','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (37, TO_DATE('2026-04-09','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 4, 4, TO_DATE('2026-04-09','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (38, TO_DATE('2026-01-22','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 5, 5, TO_DATE('2026-01-22','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (39, TO_DATE('2026-08-09','YYYY-MM-DD'), INTERVAL '0 01:00:00' DAY TO SECOND, 7, 7, TO_DATE('2026-08-09','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (40, TO_DATE('2026-08-28','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 8, 8, TO_DATE('2026-08-28','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (41, TO_DATE('2025-09-05','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 9, 9, TO_DATE('2025-09-05','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (42, TO_DATE('2025-03-13','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 11, 11, TO_DATE('2025-03-13','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (43, TO_DATE('2026-08-26','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 13, 13, TO_DATE('2026-08-26','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (44, TO_DATE('2025-12-18','YYYY-MM-DD'), INTERVAL '0 00:45:00' DAY TO SECOND, 14, 14, TO_DATE('2025-12-18','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (45, TO_DATE('2025-12-02','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 16, 16, TO_DATE('2025-12-02','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (46, TO_DATE('2026-08-27','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 17, 17, TO_DATE('2026-08-27','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (47, TO_DATE('2025-01-16','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 18, 18, TO_DATE('2025-01-16','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (48, TO_DATE('2025-01-19','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 19, 19, TO_DATE('2025-01-19','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (49, TO_DATE('2025-04-25','YYYY-MM-DD'), INTERVAL '0 01:30:00' DAY TO SECOND, 21, 21, TO_DATE('2025-04-25','YYYY-MM-DD'));
INSERT INTO SESION_ENTRENAMIENTO (id_sesion, fecha_sesion, duracion_sesion, RUTINA_id_rutina, AGENDA_id_agendar, AGENDA_fecha_agendar) VALUES (50, TO_DATE('2025-08-07','YYYY-MM-DD'), INTERVAL '0 01:15:00' DAY TO SECOND, 22, 22, TO_DATE('2025-08-07','YYYY-MM-DD'));

-- TENER: 50 registros
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.998.500-5', 1);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('15.360.060-0', 2);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('18.430.815-0', 3);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('25.960.879-1', 4);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('18.586.960-1', 5);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('20.858.183-K', 6);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('24.428.415-9', 7);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('25.987.858-6', 8);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.721.960-7', 9);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('24.833.068-6', 10);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('13.746.093-9', 11);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('25.012.372-8', 12);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('20.083.621-9', 13);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('20.426.773-1', 14);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('19.337.510-3', 15);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('17.056.747-1', 16);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('23.142.824-0', 17);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('19.606.110-K', 18);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('19.190.751-5', 19);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('24.133.155-5', 20);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('22.256.410-7', 21);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('23.028.725-2', 22);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('22.886.836-1', 23);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('18.236.009-0', 24);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('22.600.124-7', 25);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('22.970.008-1', 26);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('19.840.186-2', 27);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('17.400.346-7', 28);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('14.025.425-8', 29);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('10.042.527-0', 30);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('20.304.637-5', 31);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.354.318-3', 32);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.857.850-3', 33);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('14.819.091-7', 34);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('23.702.981-K', 35);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('11.645.033-K', 36);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('17.543.956-0', 37);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('10.192.750-4', 38);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('23.669.449-6', 39);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('24.947.890-3', 40);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('21.495.380-3', 41);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('18.225.646-3', 42);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('21.398.255-9', 43);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('15.271.957-4', 44);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('13.526.984-0', 45);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('16.664.202-7', 46);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('14.219.689-1', 47);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('15.832.730-9', 48);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('25.591.357-3', 49);
INSERT INTO TENER (CLIENTE_rut_cliente, FICHA_CLIENTE_id_ficha) VALUES ('15.983.360-7', 50);

COMMIT;
