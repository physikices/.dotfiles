; extends

; destacar só a keyword "module"
("module") @keyword.module

; destacar só a keyword "contains"
("contains") @keyword.contains

; agrupar todos os "end..." que a gramática usa
[
  "endif"
  "endwhere"
  "enddo"
  "endforall"
  "endassociate"
  "endenum"
  "endselect"
  "endprocedure"
  "endfunction"
  "endprogram"
  "endsubroutine"
  "endmodule"
  "endinterface"
  "endtype"
  "endsubmodule"
] @keyword.end

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
