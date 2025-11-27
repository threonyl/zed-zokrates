; Keywords
[
  "def"
  "struct"
  "return"
  "if"
  "else"
  "for"
  "in"
  "import"
  "from"
  "as"
  "const"
  "type"
  "mut"
  "private"
  "public"
  "asm"
  "assert"
  "log"
] @keyword

(pragma) @keyword
(import_symbol (identifier) @variable)
(import_symbol "as" (identifier) @variable)


; Types
(ty_basic) @type
(ty_struct (identifier) @type)
(type_definition (identifier) @type)
(ty_struct_definition name: (identifier) @type)

; Functions
(function_definition name: (identifier) @function)
(call_expression function: (expression (primary_expression (identifier) @function)))
(call_expression function: (expression (member_expression property: (identifier) @function)))

; Variables
(parameter name: (identifier) @variable.parameter)

; Variable definition (typed_identifier is anonymous)
(definition_statement
  (ty)
  (identifier) @variable)

(definition_statement
  (ty)
  "mut"
  (identifier) @variable)

; Assignment to variable
(definition_statement
  (assignee (identifier) @variable))

; Constants
(const_definition (identifier) @constant)

; Fields
(struct_field name: (identifier) @property)
(member_expression property: (identifier) @property)
(struct_expression field: (identifier) @property)
(struct_expression name: (identifier) @type)

; Literals
(string) @string
(decimal_literal) @number
(hex_literal) @number
(boolean_literal) @boolean

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "<<"
  ">>"
  "&"
  "|"
  "^"
  "!"
  "&&"
  "||"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "="
  "?"
  ":"
  "<--"
  "<=="
  "==="
  ".."
  "..."
] @operator

; Comments
(comment) @comment
