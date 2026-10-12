create database lavanderia_nobel;
use lavanderia_nobel;
create table usuario(
id_usuario tinyint unsigned auto_increment primary key,
tipo_de_documento enum ("CC", "PPT", "PEP", "CE", "OTRO") not null,
num_documento int unsigned not null unique,
nombre varchar (255) not null,
apellido varchar (255) not null,
fecha_de_nacimiento date not null,
nivel_educativo varchar (255) not null,
genero enum ("femenino", "masculino", "otros") not null,
estado_civil enum ("soltero", "casado", "divorciado", "viudo") not null, 
correo_electronico_1 varchar (255) not null,
correo_electronico_2 varchar (255) null,
tipo_usuario enum ("administrador", "encargado de recepcion", "encargado de ciclo de lavado y secado") not null,
direccion varchar (255) not null,
referencia_personal varchar (255) not null,
telefono_referencia_personal int unsigned not null,
nombre_referencia_personal varchar (255) not null,
parentesco_referencia_personal varchar (255) not null,
referencia_laboral varchar (255) not null,
telefono_refencia_laboral int unsigned not null,
nombre_refencia_laboral varchar (255) not null,
cargo_desempeñado varchar (255) not null,
periodo_de_trabajo date not null,
motivo_de_salida varchar (255) not null,
estado char (1) default "A" not null
);

create table cliente(
telefono int unsigned primary key,
nombre varchar (255) not null,
CC int unsigned unique,
correo_electronico_1 varchar (255)not null,
correo_electronico_2 varchar (255) null,
estado char (1) default "A" not null
);

create table servicio(
id_servicio tinyint unsigned auto_increment primary key,
tipo_de_servicio enum ("lavado y secado", "plancahdo", "secado", "otro"),
descripcion_del_servicio varchar (255) not null,
requiere_tratamiento_de_manchas char (2) default "SI",
tiempo_estimado time not null,
precio_del_servicio decimal not null,
estado char (1) default "A" not null
);

create table telefono(
id_usuario tinyint unsigned not null,
foreign key (id_usuario) references usuario (id_usuario),
telefono int unsigned not null 
);

create table orden(
codigo smallint unsigned auto_increment primary key,
fecha_de_recepcion datetime not null,
total_de_prendas tinyint not null,
observaciones varchar (255) not null,
fecha_estimada_de_entrega datetime not null,
valor_a_pagar decimal not null,
estado_de_orden enum ("recepcion", "clasificacion", "tratamiento de manchas", "lavado", "secado", "planchado", "enpaquetado", "listo para entregar") not null,
id_usuario  tinyint unsigned not null,
foreign key (id_usuario) references usuario (id_usuario),
telefono_cliente int unsigned not null,
foreign key (telefono_cliente) references cliente (telefono)
);

create table pago(
codigo_de_pagos smallint unsigned auto_increment primary key,
metodo_de_pago enum ("nequi", "daviplata", "efectivo", "otro") not null,
fecha_de_pago datetime not null,
tipo_de_pago enum ("abono", "pago completo") not null,
estado_de_pago enum ("pago completo", "saldo pendiente") not null,
total decimal not null,
saldo_pendiente decimal not null,
comprobante enum ("si", "no"),
observaciones_de_pago varchar (255) not null,
descuento decimal not null,
comsion decimal not null,
impuesto decimal not null,
codigo_orden  smallint unsigned not null,
foreign key (codigo_orden) references orden (codigo)
);

create table prenda(
codigo_orden_prenda smallint unsigned auto_increment primary key,
tipo enum ("chaqueta", "jeans", "camisas", "manteles", "sabanas", "edredones") not null,
color varchar (255) not null,
material enum ("algodon", "lino", "lana", "seda", "poliester", "licra") not null,
descripcion varchar (255) not null,
manchas enum ("si", "no") not null,
codigo_orden smallint unsigned not null,
foreign key (codigo_orden) references orden (codigo)
);

create table aplica(
codigo_orden_prenda smallint unsigned not null,
foreign key (codigo_orden_prenda) references prenda (codigo_orden_prenda),
id_servicio tinyint unsigned not null,
foreign key (id_servicio) references servicio (id_servicio)
);

/*Consultas generales por tabla ------------------------------------------------------------------------------------------------------*/
SELECT * FROM usuario;
SELECT * FROM cliente;
SELECT * FROM servicio;
SELECT * FROM telefono;
SELECT * FROM orden;
SELECT * FROM pago;
SELECT * FROM prenda;
SELECT * FROM aplica;

insert into usuario (tipo_de_documento, num_documento, nombre, apellido, fecha_de_nacimiento, nivel_educativo, genero, estado_civil,
    correo_electronico_1, correo_electronico_2, tipo_usuario, direccion, referencia_personal, telefono_referencia_personal, nombre_referencia_personal, parentesco_referencia_personal, 
    referencia_laboral, telefono_refencia_laboral, nombre_refencia_laboral, cargo_desempeñado, periodo_de_trabajo, motivo_de_salida, estado) values
('CC', 100000001, 'Andres', 'Rodriguez', '1995-03-12', 'Universitario', 'masculino', 'soltero', 'andres.rod@example.com', NULL, 'administrador', 'Calle 10 # 20-30', 'Amigo de confianza', 300000001, 'Carlos Mendoza', 'Amigo', 'Lavanderia Central', 601000001, 'Laura Torres', 'Administrador', '2024-01-15', 'Mejor oportunidad laboral', 'A'),

('CC', 100000002, 'Laura', 'Martinez', '1998-07-21', 'Tecnico', 'femenino', 'soltero', 'laura.mar@example.com', NULL, 'encargado de recepcion', 'Carrera 15 # 45-20', 'Amiga de la familia', 300000002, 'Diana Castro', 'Amiga', 'Servicios Integrales', 601000002, 'Pedro Gomez', 'Recepcionista', '2023-06-10', 'Fin de contrato', 'A'),

('CC', 100000003, 'Daniel', 'Gomez', '1992-11-05', 'Tecnologo', 'masculino', 'casado', 'daniel.gom@example.com', 'daniel.alt@example.com', 'encargado de ciclo de lavado y secado', 'Calle 50 # 12-15', 'Vecino', 300000003, 'Jorge Ramirez', 'Vecino', 'Lavaseco Moderno', 601000003, 'Marta Ruiz', 'Operario de lavado', '2022-04-01', 'Renuncia voluntaria', 'A'),

('CC', 100000004, 'Camila', 'Hernandez', '2000-02-18', 'Bachiller', 'femenino', 'soltero', 'camila.her@example.com', NULL, 'encargado de recepcion', 'Carrera 8 # 22-14', 'Amiga', 300000004, 'Sofia Lopez', 'Amiga', 'Hotel del Parque', 601000004, 'Julian Perez', 'Auxiliar de recepcion', '2024-02-01', 'Estudios', 'A'),

('CC', 100000005, 'Sebastian', 'Lopez', '1997-09-30', 'Tecnico', 'masculino', 'soltero', 'sebas.lopez@example.com', NULL, 'encargado de ciclo de lavado y secado', 'Calle 72 # 18-40', 'Primo', 300000005, 'Mateo Diaz', 'Primo', 'Textiles del Norte', 601000005, 'Andres Silva', 'Operario textil', '2023-03-15', 'Cambio de ciudad', 'A'),

('CC', 100000006, 'Valentina', 'Perez', '1996-05-14', 'Universitario', 'femenino', 'casado', 'valen.perez@example.com', NULL, 'administrador', 'Carrera 30 # 25-10', 'Hermana', 300000006, 'Natalia Perez', 'Hermana', 'Comercial Andina', 601000006, 'Felipe Rojas', 'Coordinadora', '2021-08-20', 'Fin de contrato', 'A'),

('CC', 100000007, 'Juan', 'Sanchez', '1990-12-09', 'Bachiller', 'masculino', 'divorciado', 'juan.san@example.com', NULL, 'encargado de recepcion', 'Calle 26 # 15-60', 'Amigo', 300000007, 'Oscar Moreno', 'Amigo', 'Centro Empresarial', 601000007, 'Claudia Leon', 'Recepcionista', '2020-05-10', 'Renuncia voluntaria', 'A'),

('CC', 100000008, 'Mariana', 'Torres', '2001-04-25', 'Tecnologo', 'femenino', 'soltero', 'mariana.tor@example.com', NULL, 'encargado de ciclo de lavado y secado', 'Carrera 19 # 40-12', 'Tia', 300000008, 'Patricia Rios', 'Tia', 'Lavanderia Express', 601000008, 'Ricardo Pena', 'Auxiliar de lavanderia', '2024-01-05', 'Estudios', 'A'),

('CC', 100000009, 'Nicolas', 'Ramirez', '1994-08-16', 'Universitario', 'masculino', 'soltero', 'nicolas.ram@example.com', NULL, 'administrador', 'Calle 80 # 14-25', 'Amigo', 300000009, 'David Cruz', 'Amigo', 'Grupo Empresarial Uno', 601000009, 'Monica Gil', 'Asistente administrativo', '2022-07-01', 'Mejor oferta laboral', 'A'),

('CC', 100000010, 'Isabella', 'Castro', '1999-01-28', 'Tecnico', 'femenino', 'soltero', 'isa.castro@example.com', NULL, 'encargado de recepcion', 'Carrera 11 # 60-35', 'Prima', 300000010, 'Daniela Vega', 'Prima', 'Hotel Primavera', 601000010, 'Sandra Ortiz', 'Recepcionista', '2023-09-01', 'Renuncia voluntaria', 'A'),

('CC', 100000011, 'Miguel', 'Diaz', '1988-06-11', 'Bachiller', 'masculino', 'casado', 'miguel.diaz@example.com', NULL, 'encargado de ciclo de lavado y secado', 'Calle 13 # 9-21', 'Hermano', 300000011, 'Luis Diaz', 'Hermano', 'Lavanderia San Jose', 601000011, 'Gloria Marin', 'Operario de secado', '2019-02-10', 'Fin de contrato', 'A'),

('CC', 100000012, 'Gabriela', 'Moreno', '1993-10-03', 'Universitario', 'femenino', 'divorciado', 'gabi.mor@example.com', NULL, 'administrador', 'Carrera 7 # 32-18', 'Amiga', 300000012, 'Paula Reyes', 'Amiga', 'Oficinas Capital', 601000012, 'Camilo Nieto', 'Administradora', '2020-11-15', 'Cambio profesional', 'A'),

('CC', 100000013, 'Samuel', 'Vargas', '2002-03-19', 'Bachiller', 'masculino', 'soltero', 'samuel.var@example.com', NULL, 'encargado de recepcion', 'Calle 63 # 20-45', 'Primo', 300000013, 'Esteban Vargas', 'Primo', 'Hostal Central', 601000013, 'Liliana Acosta', 'Auxiliar de recepcion', '2024-06-01', 'Estudios', 'A'),

('CC', 100000014, 'Daniela', 'Rojas', '1997-12-22', 'Tecnologo', 'femenino', 'casado', 'daniela.roj@example.com', NULL, 'encargado de ciclo de lavado y secado', 'Carrera 24 # 18-50', 'Madre', 300000014, 'Adriana Rojas', 'Madre', 'Textiles Bogota', 601000014, 'Hector Salas', 'Supervisora de lavado', '2021-04-10', 'Mejor oportunidad laboral', 'A'),

('CC', 100000015, 'David', 'Silva', '1991-07-07', 'Universitario', 'masculino', 'soltero', 'david.sil@example.com', NULL, 'administrador', 'Calle 100 # 19-22', 'Amigo', 300000015, 'Felipe Torres', 'Amigo', 'Servicios Corporativos', 601000015, 'Angela Mora', 'Coordinador administrativo', '2022-02-01', 'Renuncia voluntaria', 'A'),

('CC', 100000016, 'Sara', 'Ortega', '2000-09-13', 'Tecnico', 'femenino', 'soltero', 'sara.ort@example.com', NULL, 'encargado de recepcion', 'Carrera 16 # 35-28', 'Hermana', 300000016, 'Luisa Ortega', 'Hermana', 'Hotel Los Pinos', 601000016, 'Mario Cardenas', 'Recepcionista', '2023-05-20', 'Fin de contrato', 'A'),

('CC', 100000017, 'Alejandro', 'Mendoza', '1989-02-26', 'Bachiller', 'masculino', 'casado', 'alejo.men@example.com', NULL, 'encargado de ciclo de lavado y secado', 'Calle 44 # 28-19', 'Vecino', 300000017, 'Ruben Arias', 'Vecino', 'Lavanderia El Sol', 601000017, 'Teresa Parra', 'Operario de lavado', '2020-01-12', 'Cambio de empleo', 'A'),

('CC', 100000018, 'Natalia', 'Cruz', '1995-11-17', 'Tecnologo', 'femenino', 'soltero', 'natalia.cruz@example.com', NULL, 'administrador', 'Carrera 5 # 48-30', 'Amiga', 300000018, 'Juliana Pardo', 'Amiga', 'Administraciones del Centro', 601000018, 'Roberto Luna', 'Administradora', '2022-09-01', 'Renuncia voluntaria', 'A'),

('CC', 100000019, 'Mateo', 'Reyes', '2001-06-08', 'Tecnico', 'masculino', 'soltero', 'mateo.rey@example.com', NULL, 'encargado de recepcion', 'Calle 27 # 16-42', 'Primo', 300000019, 'Santiago Reyes', 'Primo', 'Hotel Mirador', 601000019, 'Beatriz Cano', 'Auxiliar de recepcion', '2024-03-01', 'Estudios', 'A'),

('CC', 100000020, 'Juliana', 'Vega', '1998-04-02', 'Universitario', 'femenino', 'casado', 'juliana.vega@example.com', NULL, 'encargado de ciclo de lavado y secado', 'Carrera 40 # 12-33', 'Hermano', 300000020, 'Andres Vega', 'Hermano', 'Lavanderia Premium', 601000020, 'Cecilia Fuentes', 'Supervisora de lavado', '2023-01-15', 'Mejor oferta laboral', 'A');
select * from usuario;

insert into cliente (  telefono, nombre, CC, correo_electronico_1, correo_electronico_2, estado) values 
(3100000001, 'Andres Rodriguez', 100100001, 'andres.rod@example.com', NULL, 'A'),
(3100000002, 'Laura Martinez', 100100002, 'laura.mar@example.com', NULL, 'A'),
(3100000003, 'Daniel Gomez', 100100003, 'daniel.gom@example.com', 'daniel.alt@example.com', 'A'),
(3100000004, 'Camila Hernandez', 100100004, 'camila.her@example.com', NULL, 'A'),
(3100000005, 'Sebastian Lopez', 100100005, 'sebas.lopez@example.com', NULL, 'A'),
(3100000006, 'Valentina Perez', 100100006, 'valen.perez@example.com', NULL, 'A'),
(3100000007, 'Juan Sanchez', 100100007, 'juan.san@example.com', NULL, 'A'),
(3100000008, 'Mariana Torres', 100100008, 'mariana.tor@example.com', NULL, 'A'),
(3100000009, 'Nicolas Ramirez', 100100009, 'nicolas.ram@example.com', NULL, 'A'),
(3100000010, 'Isabella Castro', 100100010, 'isa.castro@example.com', NULL, 'A'),
(3100000011, 'Miguel Diaz', 100100011, 'miguel.diaz@example.com', NULL, 'A'),
(3100000012, 'Gabriela Moreno', 100100012, 'gabi.mor@example.com', NULL, 'A'),
(3100000013, 'Samuel Vargas', 100100013, 'samuel.var@example.com', NULL, 'A'),
(3100000014, 'Daniela Rojas', 100100014, 'daniela.roj@example.com', NULL, 'A'),
(3100000015, 'David Silva', 100100015, 'david.sil@example.com', NULL, 'A'),
(3100000016, 'Sara Ortega', 100100016, 'sara.ort@example.com', NULL, 'A'),
(3100000017, 'Alejandro Mendoza', 100100017, 'alejo.men@example.com', NULL, 'A'),
(3100000018, 'Natalia Cruz', 100100018, 'natalia.cruz@example.com', NULL, 'A'),
(3100000019, 'Mateo Reyes', 100100019, 'mateo.rey@example.com', NULL, 'A'),
(3100000020, 'Juliana Vega', 100100020, 'juliana.vega@example.com', NULL, 'A');
select * from cliente;

insert into servicio (tipo_de_servicio, descripcion_del_servicio, requiere_tratamiento_de_manchas, tiempo_estimado, precio_del_servicio, estado) 
values
('lavado y secado', 'Lavado y secado de ropa cotidiana', 'NO', '01:30:00', 15000.00, 'A'),
('lavado y secado', 'Lavado y secado de ropa delicada', 'NO', '02:00:00', 22000.00, 'A'),
('plancahdo', 'Planchado de camisas', 'NO', '00:30:00', 5000.00, 'A'),
('secado', 'Secado de ropa cotidiana', 'NO', '00:45:00', 8000.00, 'A'),
('otro', 'Tratamiento especial para manchas difíciles', 'SI', '01:00:00', 12000.00, 'A'),
('lavado y secado', 'Lavado de cobijas individuales', 'NO', '02:30:00', 25000.00, 'A'),
('lavado y secado', 'Lavado de cobijas dobles', 'SI', '03:00:00', 35000.00, 'A'),
('plancahdo', 'Planchado de pantalones', 'NO', '00:25:00', 6000.00, 'A'),
('lavado y secado', 'Lavado de jeans', 'NO', '01:30:00', 12000.00, 'A'),
('secado', 'Secado de cobijas', 'NO', '01:00:00', 15000.00, 'A'),
('lavado y secado', 'Lavado de cortinas', 'SI', '02:30:00', 30000.00, 'A'),
('plancahdo', 'Planchado de vestidos', 'NO', '00:40:00', 10000.00, 'A'),
('lavado y secado', 'Lavado de uniformes de trabajo', 'SI', '01:45:00', 18000.00, 'A'),
('secado', 'Secado de prendas delicadas', 'NO', '00:50:00', 10000.00, 'A'),
('otro', 'Desmanchado de camisas', 'SI', '00:45:00', 8000.00, 'A'),
('lavado y secado', 'Lavado de toallas', 'NO', '01:15:00', 10000.00, 'A'),
('lavado y secado', 'Lavado de sábanas', 'NO', '01:30:00', 16000.00, 'A'),
('plancahdo', 'Planchado de sábanas', 'NO', '00:35:00', 9000.00, 'A'),
('lavado y secado', 'Lavado de chaquetas', 'SI', '02:00:00', 25000.00, 'A'),
('otro', 'Servicio especial para prendas delicadas', 'SI', '02:00:00', 28000.00, 'A');
select * from servicio;

insert into telefono (id_usuario, telefono)
values     ("1", "3001234567"),
    ("2", "3012345678"),
    ("3", "3023456789"),
    ("4", "3104567890"),
    ("5", "3115678901"),
    ("6", "3126789012"),
    ("7", "3137890123"),
    ("8", "3148901234"),
    ("9", "3159012345"),
    ("10", "3160123456"),
    ("11", "3171234567"),
    ("12", "3182345678"),
    ("13", "3193456789"),
    ("14", "3204567890"),
    ("15", "3215678901"),
    ("16", "3226789012"),
    ("17", "3237890123"),
    ("18", "3248901234"),
    ("19", "3259012345"),
    ("20", "3260123456");

INSERT INTO orden (fecha_de_recepcion ,total_de_prendas, observaciones, fecha_estimada_de_entrega, valor_a_pagar, estado_de_orden, id_usuario, telefono_cliente) 
VALUES ('2026-10-01 08:30:00', 5, 'Ropa de uso diario', '2026-10-02 16:00:00', 25000, 'recepcion', 1, 3100000001),
('2026-10-01 09:00:00', 3, 'Camisas blancas', '2026-10-02 17:00:00', 18000, 'clasificacion', 2, 3100000002),
('2026-10-01 09:30:00', 7, 'Ropa con manchas difíciles', '2026-10-03 14:00:00', 35000, 'tratamiento de manchas', 3, 3100000003),
('2026-10-01 10:00:00', 4, 'Prendas delicadas', '2026-10-02 15:00:00', 22000, 'lavado', 1, 3100000004),
('2026-10-01 10:30:00', 6, 'Jeans y pantalones', '2026-10-03 12:00:00', 30000, 'secado', 2, 3100000005),
('2026-10-01 11:00:00', 2, 'Trajes para oficina', '2026-10-03 16:00:00', 40000, 'planchado', 3, 3100000006),
('2026-10-01 11:30:00', 8, 'Ropa de cama', '2026-10-04 10:00:00', 45000, 'enpaquetado', 1, 3100000007),
('2026-10-01 12:00:00', 3, 'Toallas y tendidos', '2026-10-02 18:00:00', 20000, 'listo para entregar', 2, 3100000008),
('2026-10-02 08:00:00', 5, 'Uniformes escolares', '2026-10-03 16:00:00', 28000, 'recepcion', 3, 3100000009),
('2026-10-02 08:30:00', 4, 'Camisas y pantalones', '2026-10-04 12:00:00', 32000, 'clasificacion', 1, 3100000010),
('2026-10-02 09:00:00', 6, 'Manchas de grasa', '2026-10-04 15:00:00', 38000, 'tratamiento de manchas', 2, 3100000011),
('2026-10-02 09:30:00', 2, 'Vestidos delicados', '2026-10-03 17:00:00', 26000, 'lavado', 3, 3100000012),
('2026-10-02 10:00:00', 9, 'Ropa familiar', '2026-10-04 16:00:00', 42000, 'secado', 1, 3100000013),
('2026-10-02 10:30:00', 3, 'Pantalones formales', '2026-10-04 17:00:00', 24000, 'planchado', 2, 3100000014),
('2026-10-02 11:00:00', 5, 'Sábanas y fundas', '2026-10-05 12:00:00', 35000, 'enpaquetado', 3, 3100000015),
('2026-10-02 11:30:00', 4, 'Ropa deportiva', '2026-10-03 18:00:00', 22000, 'listo para entregar', 1, 3100000016),
('2026-10-03 08:00:00', 7, 'Chaquetas y abrigos', '2026-10-05 16:00:00', 50000, 'recepcion', 2, 3100000017),
('2026-10-03 08:30:00', 3, 'Prendas con manchas de tinta', '2026-10-05 17:00:00', 30000, 'tratamiento de manchas', 3, 3100000018),
('2026-10-03 09:00:00', 6, 'Cobijas pequeñas', '2026-10-06 14:00:00', 40000, 'lavado', 1, 3100000019),
('2026-10-03 09:30:00', 2, 'Camisas para evento', '2026-10-04 16:00:00', 18000, 'listo para entregar', 2, 3100000020);

INSERT INTO pago (metodo_de_pago, fecha_de_pago, tipo_de_pago, estado_de_pago, total, saldo_pendiente, comprobante, observaciones_de_pago, descuento, comsion, impuesto, codigo_orden) VALUES
('nequi', '2026-10-01 08:35:00', 'pago completo', 'pago completo', 25000, 0, 'si', 'Pago realizado por Nequi', 0, 0, 0, 21),
('efectivo', '2026-10-01 09:05:00', 'abono', 'saldo pendiente', 10000, 8000, 'no', 'Abono inicial en efectivo', 0, 0, 0, 22),
('daviplata', '2026-10-01 09:35:00', 'pago completo', 'pago completo', 35000, 0, 'si', 'Pago completo por Daviplata', 0, 0, 0, 23),
('efectivo', '2026-10-01 10:05:00', 'abono', 'saldo pendiente', 12000, 10000, 'no', 'Abono para prendas delicadas', 0, 0, 0, 24),
('nequi', '2026-10-01 10:35:00', 'pago completo', 'pago completo', 30000, 0, 'si', 'Pago completo por Nequi', 0, 0, 0, 25),
('otro', '2026-10-01 11:05:00', 'abono', 'saldo pendiente', 20000, 20000, 'si', 'Abono parcial para trajes', 0, 0, 0, 26),
('efectivo', '2026-10-01 11:35:00', 'pago completo', 'pago completo', 45000, 0, 'no', 'Pago en efectivo', 0, 0, 0, 27),
('daviplata', '2026-10-01 12:05:00', 'pago completo', 'pago completo', 20000, 0, 'si', 'Pago completo por Daviplata', 0, 0, 0, 28),
('nequi', '2026-10-02 08:05:00', 'abono', 'saldo pendiente', 15000, 13000, 'si', 'Abono para uniformes escolares', 0, 0, 0, 29),
('efectivo', '2026-10-02 08:35:00', 'pago completo', 'pago completo', 32000, 0, 'no', 'Pago completo en efectivo', 0, 0, 0, 30),
('daviplata', '2026-10-02 09:05:00', 'abono', 'saldo pendiente', 18000, 20000, 'si', 'Abono por tratamiento de manchas', 0, 0, 0, 31),
('nequi', '2026-10-02 09:35:00', 'pago completo', 'pago completo', 26000, 0, 'si', 'Pago completo por Nequi', 0, 0, 0, 32),
('efectivo', '2026-10-02 10:05:00', 'abono', 'saldo pendiente', 20000, 22000, 'no', 'Abono parcial de ropa familiar', 0, 0, 0, 33),
('otro', '2026-10-02 10:35:00', 'pago completo', 'pago completo', 24000, 0, 'si', 'Pago mediante otro método', 0, 0, 0, 34),
('daviplata', '2026-10-02 11:05:00', 'abono', 'saldo pendiente', 15000, 20000, 'si', 'Abono para sábanas y fundas', 0, 0, 0, 35),
('efectivo', '2026-10-02 11:35:00', 'pago completo', 'pago completo', 22000, 0, 'no', 'Pago completo en efectivo', 0, 0, 0, 36),
('nequi', '2026-10-03 08:05:00', 'abono', 'saldo pendiente', 25000, 25000, 'si', 'Abono para chaquetas y abrigos', 0, 0, 0, 37),
('daviplata', '2026-10-03 08:35:00', 'abono', 'saldo pendiente', 10000, 20000, 'si', 'Abono para prendas con manchas de tinta', 0, 0, 0, 38),
('efectivo', '2026-10-03 09:05:00', 'pago completo', 'pago completo', 40000, 0, 'no', 'Pago completo en efectivo', 0, 0, 0, 39),
('nequi', '2026-10-03 09:35:00', 'pago completo', 'pago completo', 18000, 0, 'si', 'Pago completo por Nequi', 0, 0, 0, 40);

INSERT INTO prenda (tipo,color,material,descripcion,manchas,codigo_orden) VALUES
('chaqueta', 'Negro', 'poliester', 'Chaqueta de uso diario', 'no', 21),
('jeans', 'Azul', 'algodon', 'Jeans con desgaste leve', 'si', 22),
('camisas', 'Blanco', 'algodon', 'Camisa formal de manga larga', 'no', 23),
('manteles', 'Beige', 'lino', 'Mantel para comedor', 'si', 24),
('sabanas', 'Blanco', 'algodon', 'Juego de sábanas sencillo', 'no', 25),
('edredones', 'Gris', 'poliester', 'Edredón para cama doble', 'si', 26),
('chaqueta', 'Azul oscuro', 'lana', 'Chaqueta para clima frío', 'no', 27),
('jeans', 'Negro', 'algodon', 'Pantalón de mezclilla negro', 'no', 28),
('camisas', 'Azul claro', 'poliester', 'Camisa para oficina', 'si', 29),
('manteles', 'Blanco', 'algodon', 'Mantel para eventos', 'no', 30),
('sabanas', 'Rosado', 'algodon', 'Sábanas para cama sencilla', 'si', 31),
('edredones', 'Azul', 'poliester', 'Edredón acolchado', 'no', 32),
('chaqueta', 'Café', 'cuero', 'Chaqueta de color café', 'si', 33),
('jeans', 'Gris', 'algodon', 'Jeans de corte clásico', 'no', 34),
('camisas', 'Negro', 'seda', 'Camisa delicada', 'no', 35),
('manteles', 'Verde', 'lino', 'Mantel decorativo', 'si', 36),
('sabanas', 'Amarillo', 'algodon', 'Sábanas para habitación', 'no', 37),
('edredones', 'Blanco', 'lana', 'Edredón grueso', 'si', 38),
('chaqueta', 'Rojo', 'poliester', 'Chaqueta deportiva', 'no', 39),
('camisas', 'Verde', 'licra', 'Camisa elástica', 'si', 40);

INSERT INTO aplica (codigo_orden_prenda, id_servicio) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);