create table merlin.constraint_model_specification(
  model_id integer not null
    references merlin.mission_model
      on update cascade
      on delete cascade,
  constraint_id integer not null,
  constraint_revision integer, -- latest is NULL

  constraint constraint_model_spec_pkey
    primary key (model_id, constraint_id),
  constraint model_spec_constraint_exists
    foreign key (constraint_id)
      references merlin.constraint_metadata(id)
      on update cascade
      on delete restrict,
  constraint model_spec_constraint_definition_exists
    foreign key (constraint_id, constraint_revision)
      references merlin.constraint_definition(constraint_id, revision)
      on update cascade
      on delete restrict
);

comment on table merlin.constraint_model_specification is e''
'The set of constraints that all plans using the model should include in their constraint specification.';
comment on column merlin.constraint_model_specification.model_id is e''
'The model which this specification is for. Half of the primary key.';
comment on column merlin.constraint_model_specification.constraint_id is e''
'The id of a specific constraint in the specification. Half of the primary key.';
comment on column merlin.constraint_model_specification.constraint_revision is e''
'The version of the constraint definition to use. Leave NULL to use the latest version.';
