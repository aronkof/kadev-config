# adapting to a new keyboard

### modifier setup

to start we should begin with the `Capslock` modifier setup below

<pre><code>
  clear lock
  clear mod5
  add mod5 = Mode_switch
  keycode 66 = Mode_switch
</pre></code>

### custom definitions 
  * using the modifier setup we can map the 3rd and 4th argument when mapping keys
  * `keycode <keycode> = regular Shift Mode_switch Mode_switch+Shift`

here's an example rempping the key 1 that has the `keycode` 10 to behave differently
`keycode  10 = 1 exclam F1 dead_tilde`

* result is: 
  + regular stroke `1` will output `1`
  + `shift+1` will output `!`
  + `capslock+1` will output `F1`
  + `shift+capslock+1` will output `dead_tilde` which is the international usage of `~` waiting for the next character
