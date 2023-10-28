/*
La siguiente base de datos se enfocara en el futbol club barcelona en la liga
española,en el se podran visualizar los jugadores,detalles de los mismos,
goles,tarjetas y partidos jugados.El enfoque es unicamente en el club
previamente dicho, por lo cual algunos datos de los equipos rivales,como los
autores de los goles, no podran ser visualizados.
*/
drop database if exists barcelona_liga_española;

create database if not exists Barcelona_liga_española;

use barcelona_liga_española;

SET foreign_key_checks = 0;

drop table if exists Jugadores;

create table if not exists Jugadores(
	JugadorID int primary key auto_increment comment "Llave primaria jugador",
	NombreApellido varchar(100) comment "Nombre y apellido del jugador",
    Camiseta smallint comment "Numero de camiseta del jugador",
    EnClub boolean comment "si esta en el club actualmente o no"
);

drop table if exists detallesJugadores;

create table if not exists detallesJugadores(
	DetalleID int primary key auto_increment comment "Llave primaria detalle",
    JugadorID int comment "Jugador al que se le hace referencia",
    Posicion varchar(50) comment "Posicion del jugador",
    PiernaHabil enum("Zurda","Derecha","Ambidiestro") comment "Pierna habil del jugador",
    Nacionalidad varchar(50) comment "Nacionalidad del jugador",
    constraint fk_detalleJugadores foreign key(JugadorID)
    references jugadores(JugadorID) on delete cascade on update cascade
);

drop table if exists Rivales;
create table if not exists Rivales(
	RivalID int primary key auto_increment comment "Llave primaria gol",
    Nombre varchar(100) comment "Nombre del equipo",
    Estadio varchar(100) comment "Nombre del estadio del rival"
);

drop table if exists Partidos;
create table if not exists Partidos(
	PartidoID int primary key auto_increment comment "Llave primaria partido",
    RivalID int comment "Rival del partido",
    GolesRival tinyint comment "Cantidad de goles que anoto el rival",
    Fecha date comment "Fecha del partido",
    EstadioJugado varchar(100) comment "Lugar donde se jugo el encuentro",
    constraint fk_partidosRivales foreign key(RivalID)
    references rivales(RivalID) on delete cascade on update cascade
);

drop table if exists Goles;
create table if not exists Goles(
	GolID int primary key auto_increment comment "Llave primaria gol",
	Minuto char comment "Minuto en que se anoto el gol",
    JugadorID int comment "Jugador que anoto el gol",
    PartidoID int comment "Partido en que se anoto el gol",
    constraint fk_golesJugadores foreign key(JugadorID)
    references jugadores(JugadorID) on delete cascade on update cascade,
    constraint fk_golesPartidos foreign key(PartidoID) 
    references partidos(PartidoID) on delete cascade on update cascade
);


drop table if exists Tarjetas;
create table Tarjetas(
	TarjetaID int primary key auto_increment comment "Llave primaria tarjeta",
    JugadorID int comment "Jugador que recibio la tarjeta",
    PartidoID int comment "Partido en el cual se realizo la tarjeta",
    Color enum("Amarilla","Roja"),
    constraint fk_tarjetasJugadores foreign key(JugadorID)
    references jugadores(JugadorID) on delete cascade on update cascade,
    constraint fk_tarjetasPartidos foreign key(PartidoID)
    references partidos(PartidoID) on delete cascade on update cascade
);

SET foreign_key_checks = 1;
