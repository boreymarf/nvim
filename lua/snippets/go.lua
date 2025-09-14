local ls = require 'luasnip'
local s = ls.snippet
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local sn = ls.snippet_node

-- Function to convert first character to lowercase
local lowercase_first = function(args)
  local text = args[1][1] or ''
  return text:sub(1, 1):lower() .. text:sub(2)
end

-- Function to prepend "Init" to the interface name
local prepend_init = function(args)
  local text = args[1][1] or ''
  return 'Init' .. text
end

return {
  -- Inits the repo by adding interface, struct and initstruct
  s(
    'initrepo',
    fmt(
      [[
import (
	"database/sql"
	"fmt"
)

type {} interface {{
}}

type {} struct {{
	db *sql.DB
}}

var _ {} = (*{})(nil)

func {}(db *sql.DB) ({}, error) {{
	repo := &{}{{db: db}}

	if err := repo.createTable(); err != nil {{
		return nil, fmt.Errorf("migration failed: %w", err)
	}}

	return repo, nil
}}

func (r *{}) createTable() error {{
	query := `
	CREATE TABLE IF NOT EXISTS {} (
		id INTEGER PRIMARY KEY AUTOINCREMENT
  )`

	_, err := r.db.Exec(query)
	if err != nil {{
		return err
	}}

	return nil
}}

  ]],
      {
        i(1, 'interfacename'), -- Interface name
        f(lowercase_first, { 1 }), -- structName
        rep(1), -- InterfaceName
        f(lowercase_first, { 1 }), -- structName
        f(prepend_init, { 1 }), -- InitInterfaceName
        rep(1), -- InterfaceName
        f(lowercase_first, { 1 }), -- structName
        f(lowercase_first, { 1 }), -- structName
        i(2, 'db_table'), -- db_table_name
      }
    )
  ),
}
