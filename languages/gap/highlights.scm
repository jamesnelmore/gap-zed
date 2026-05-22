; NOTE: In case multiple queries match, last query wins — go from least
; specific to most specific.
(identifier) @variable

; Constants
; convention: constants are of the form ALL_CAPS_AND_UNDERSCORES, length >= 2
((identifier) @constant
  (#match? @constant "^[A-Z_][A-Z_]+$"))

; Functions
(assignment_statement
  left: (identifier) @function) @function.definition

(assignment_statement
  left: (identifier) @function
  right: (function))

(assignment_statement
  left: (identifier) @function
  right: (atomic_function))

(assignment_statement
  left: (identifier) @function
  right: (lambda))

(call
  function: (identifier) @function.call) @function.call.definition

((call
  function: (identifier) @function.builtin)
  (#any-of? @function.builtin "Assert" "Info" "IsBound" "Unbind" "TryNextMethod"))

(parameters
  (identifier) @variable.parameter)

(qualified_parameters
  (identifier) @variable.parameter)

(qualified_parameters
  (qualified_identifier
    (identifier) @variable.parameter))

(lambda_parameters
  (identifier) @variable.parameter)

; arg is treated specially when it is the only parameter of a function
((parameters
  .
  (identifier) @variable.parameter .)
  (#eq? @variable.parameter "arg"))

((qualified_parameters
  .
  (identifier) @variable.parameter .)
  (#eq? @variable.parameter "arg"))

((qualified_parameters
  .
  (qualified_identifier
    (identifier) @variable.parameter) .)
  (#eq? @variable.parameter "arg"))

((lambda_parameters
  .
  (identifier) @variable.parameter .)
  (#eq? @variable.parameter "arg"))

(locals
  (identifier) @variable.parameter)

; Literals
(bool) @boolean

(integer) @number

(float) @number

(string) @string

(char) @string

(escape_sequence) @string.escape

[
  (help_topic)
  (help_book)
] @string.special

(tilde) @variable.special

; Record selectors
(record_entry
  left: [
    (identifier)
    (integer)
  ] @property)

(record_selector
  selector: [
    (identifier)
    (integer)
  ] @property)

(component_selector
  selector: [
    (identifier)
    (integer)
  ] @property)

(function_call_option
  [
    (identifier)
    (record_entry ; Record entries specify global properties in function calls
      left: [
        (identifier)
        (integer)
      ])
  ] @property)

(help_statement
  (help_selector) @property)

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "^"
  "->"
  ":="
  "<"
  "<="
  "<>"
  "="
  ">"
  ">="
  ".."
  (ellipsis)
] @operator

(help_statement
  (help_operator) @operator)

; Keywords
[
  (break_statement) @keyword.break
  (continue_statement) @keyword.continue
  "atomic" @keyword
  (quit_statement) @keyword
]

[
  "function" @keyword.function
  "local" @keyword.local
  "end" @keyword.end
]

[
  "and" @keyword.operator
  "in" @keyword.operator
  "mod" @keyword.operator
  "not" @keyword.operator
  "or" @keyword.operator
]

"rec" @keyword.type

[
  "readonly" @keyword.modifier
  "readwrite" @keyword.modifier
]

(atomic_function
  "atomic" @keyword.modifier)

[
  "for" @keyword.repeat
  "while" @keyword.repeat
  "do" @keyword.repeat
  "od" @keyword.repeat
  "repeat" @keyword.repeat
  "until" @keyword.repeat
]

[
  "if" @keyword.conditional
  "then" @keyword.conditional
  "elif" @keyword.conditional
  "else" @keyword.conditional
  "fi" @keyword.conditional
]

"return" @keyword.return

(pragma) @preproc @keyword.directive

; Punctuation
[
  ","
  ";"
  "."
  "!."
  ":"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "!["
  "]"
  "{"
  "}"
] @punctuation.bracket

(help_statement
  "?" @punctuation.special)

; Comments
(comment) @comment
