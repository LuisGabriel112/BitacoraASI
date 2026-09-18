-- Más ejes de personalización del personaje. Los tres campos viejos
-- (color_piel, color_cuerpo, accesorio) no se tocan: las cuentas existentes
-- conservan su apariencia y caen al default de cada campo nuevo.

alter table usuarios add column if not exists color_detalle text not null default '#222222';
alter table usuarios add column if not exists forma_cuerpo text not null default 'normal';
alter table usuarios add column if not exists cara text not null default 'feliz';
alter table usuarios add column if not exists espalda text not null default 'ninguna';
