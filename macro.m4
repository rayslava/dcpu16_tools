divert(`-1')
define(`foreach', `pushdef(`$1')_foreach($@)popdef(`$1')')
define(`_arg1', `$1')
define(`_foreach', `ifelse(`$2', `()', `',
  `define(`$1', _arg1$2)$3`'$0(`$1', (shift$2), `$3')')')
  divert`'dnl

define(`current_ret_num', 0)
define(`next_ret',`define(`current_ret_num',eval(current_ret_num+1)) define(`current_ret_name',`__ret_'current_ret_num)')

define(`call', `    SET PUSH, 'current_ret_name`
    SET PC, $1
'current_ret_name`:
'next_ret)

define(`reverse', `ifelse(`$#', `0', , `$#', `1', ``$1'',
                               `reverse(shift($@)), `$1'')')

define(`invoke', ` SET PUSH, current_ret_name
foreach(x, (`reverse(shift($@))'), ` SET PUSH, 'x`
') SET PC, $1
current_ret_name:next_ret')

define(`jmp', ` SET PC, ')
define(`ret', ` SET PC, POP
')
defn(`JMP', jmp)
defn(`RET', ret)
