; extends

; destacar só a keyword "module"
("module") @keyword.module

; destacar só a keyword "contains"
("contains") @keyword.contains

; agrupar todos os "end..." que a gramática usa
[
  "abstract"
  "associate"
  "endassociate"
  "enum"
  "endenum"
  "select"
  "endselect"
  "interface"
  "endinterface"
  "type"
  "endtype"
] @keyword.specials

; agrupar estruturas de repetição e condicional
[
  "where"
  "endwhere"
  "do"
  "enddo"
  "if"
  "then"
  "endif"
  "else"
  "elseif"
  "forall"
  "endforall"
] @keyword.control

; agrupar estrutras de declaração
[
  "elemental"
  "pure"
  "procedure"
  "endprocedure"
  "function"
  "endfunction"
  "program"
  "endprogram"
  "subroutine"
  "endsubroutine"
  "module"
  "endmodule"
  "submodule"
  "endsubmodule"
] @keyword.declaration

; TIPOS INTRÍNSECOS MESMO COM PARAMETRIZAÇÃO (ex: real(dp))
((intrinsic_type) @type.real
  (#eq? @type.real "real"))

((intrinsic_type) @type.integer
  (#eq? @type.integer "integer"))

((intrinsic_type) @type.logical
  (#eq? @type.logical "logical"))

((intrinsic_type) @type.complex
  (#eq? @type.complex "complex"))

; TYPE-BOUND MEMBERS (obj%name)
(derived_type_member_expression
  (type_member) @variable.member.bound)

; --- chamadas de função/subroutine
(subroutine_call (identifier) @fortran.func.call)
