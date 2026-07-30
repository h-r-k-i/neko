bits 32

extern isr_handler

global isr_common
isr_common:
    pusha

    mov ax, ds
    push eax

    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call isr_handler

    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    popa
    add esp, 8
    iret

; this table is to make sure the ISR stack is as usual lol:

extern isr_common
global isr0
isr0:
	cli
	push 0
	push 0
	jmp isr_common

global isr1
isr1:
	cli
	push 0
	push 1
	jmp isr_common

global isr2
isr2:
	cli
	push 0
	push 2
	jmp isr_common

global isr3
isr3:
	cli
	push 0
	push 3
	jmp isr_common

global isr4
isr4:
	cli
	push 0
	push 4
	jmp isr_common

global isr5
isr5:
	cli
	push 0
	push 5
	jmp isr_common

global isr6
isr6:
	cli
	push 0
	push 6
	jmp isr_common

global isr7
isr7:
	cli
	push 0
	push 7
	jmp isr_common

global isr8
isr8:
	cli
	push 8
	jmp isr_common

global isr9
isr9:
	cli
	push 0
	push 9
	jmp isr_common

global isr10
isr10:
	cli
	push 10
	jmp isr_common

global isr11
isr11:
	cli
	push 11
	jmp isr_common

global isr12
isr12:
	cli
	push 12
	jmp isr_common

global isr13
isr13:
	cli
	push 13
	jmp isr_common

global isr14
isr14:
	cli
	push 14
	jmp isr_common

global isr15
isr15:
	cli
	push 0
	push 15
	jmp isr_common

global isr16
isr16:
	cli
	push 0
	push 16
	jmp isr_common

global isr17
isr17:
	cli
	push 17
	jmp isr_common

global isr18
isr18:
	cli
	push 0
	push 18
	jmp isr_common

global isr19
isr19:
	cli
	push 0
	push 19
	jmp isr_common

global isr20
isr20:
	cli
	push 0
	push 20
	jmp isr_common

global isr21
isr21:
	cli
	push 0
	push 21
	jmp isr_common

global isr22
isr22:
	cli
	push 0
	push 22
	jmp isr_common

global isr23
isr23:
	cli
	push 0
	push 23
	jmp isr_common

global isr24
isr24:
	cli
	push 0
	push 24
	jmp isr_common

global isr25
isr25:
	cli
	push 0
	push 25
	jmp isr_common

global isr26
isr26:
	cli
	push 0
	push 26
	jmp isr_common

global isr27
isr27:
	cli
	push 0
	push 27
	jmp isr_common

global isr28
isr28:
	cli
	push 0
	push 28
	jmp isr_common

global isr29
isr29:
	cli
	push 0
	push 29
	jmp isr_common

global isr30
isr30:
	cli
	push 0
	push 30
	jmp isr_common

global isr31
isr31:
	cli
	push 0
	push 31
	jmp isr_common

global isr32
isr32:
	cli
	push 0
	push 32
	jmp isr_common

global isr33
isr33:
	cli
	push 0
	push 33
	jmp isr_common

global isr34
isr34:
	cli
	push 0
	push 34
	jmp isr_common

global isr35
isr35:
	cli
	push 0
	push 35
	jmp isr_common

global isr36
isr36:
	cli
	push 0
	push 36
	jmp isr_common

global isr37
isr37:
	cli
	push 0
	push 37
	jmp isr_common

global isr38
isr38:
	cli
	push 0
	push 38
	jmp isr_common

global isr39
isr39:
	cli
	push 0
	push 39
	jmp isr_common

global isr40
isr40:
	cli
	push 0
	push 40
	jmp isr_common

global isr41
isr41:
	cli
	push 0
	push 41
	jmp isr_common

global isr42
isr42:
	cli
	push 0
	push 42
	jmp isr_common

global isr43
isr43:
	cli
	push 0
	push 43
	jmp isr_common

global isr44
isr44:
	cli
	push 0
	push 44
	jmp isr_common

global isr45
isr45:
	cli
	push 0
	push 45
	jmp isr_common

global isr46
isr46:
	cli
	push 0
	push 46
	jmp isr_common

global isr47
isr47:
	cli
	push 0
	push 47
	jmp isr_common

global isr48
isr48:
	cli
	push 0
	push 48
	jmp isr_common

global isr49
isr49:
	cli
	push 0
	push 49
	jmp isr_common

global isr50
isr50:
	cli
	push 0
	push 50
	jmp isr_common

global isr51
isr51:
	cli
	push 0
	push 51
	jmp isr_common

global isr52
isr52:
	cli
	push 0
	push 52
	jmp isr_common

global isr53
isr53:
	cli
	push 0
	push 53
	jmp isr_common

global isr54
isr54:
	cli
	push 0
	push 54
	jmp isr_common

global isr55
isr55:
	cli
	push 0
	push 55
	jmp isr_common

global isr56
isr56:
	cli
	push 0
	push 56
	jmp isr_common

global isr57
isr57:
	cli
	push 0
	push 57
	jmp isr_common

global isr58
isr58:
	cli
	push 0
	push 58
	jmp isr_common

global isr59
isr59:
	cli
	push 0
	push 59
	jmp isr_common

global isr60
isr60:
	cli
	push 0
	push 60
	jmp isr_common

global isr61
isr61:
	cli
	push 0
	push 61
	jmp isr_common

global isr62
isr62:
	cli
	push 0
	push 62
	jmp isr_common

global isr63
isr63:
	cli
	push 0
	push 63
	jmp isr_common

global isr64
isr64:
	cli
	push 0
	push 64
	jmp isr_common

global isr65
isr65:
	cli
	push 0
	push 65
	jmp isr_common

global isr66
isr66:
	cli
	push 0
	push 66
	jmp isr_common

global isr67
isr67:
	cli
	push 0
	push 67
	jmp isr_common

global isr68
isr68:
	cli
	push 0
	push 68
	jmp isr_common

global isr69
isr69:
	cli
	push 0
	push 69
	jmp isr_common

global isr70
isr70:
	cli
	push 0
	push 70
	jmp isr_common

global isr71
isr71:
	cli
	push 0
	push 71
	jmp isr_common

global isr72
isr72:
	cli
	push 0
	push 72
	jmp isr_common

global isr73
isr73:
	cli
	push 0
	push 73
	jmp isr_common

global isr74
isr74:
	cli
	push 0
	push 74
	jmp isr_common

global isr75
isr75:
	cli
	push 0
	push 75
	jmp isr_common

global isr76
isr76:
	cli
	push 0
	push 76
	jmp isr_common

global isr77
isr77:
	cli
	push 0
	push 77
	jmp isr_common

global isr78
isr78:
	cli
	push 0
	push 78
	jmp isr_common

global isr79
isr79:
	cli
	push 0
	push 79
	jmp isr_common

global isr80
isr80:
	cli
	push 0
	push 80
	jmp isr_common

global isr81
isr81:
	cli
	push 0
	push 81
	jmp isr_common

global isr82
isr82:
	cli
	push 0
	push 82
	jmp isr_common

global isr83
isr83:
	cli
	push 0
	push 83
	jmp isr_common

global isr84
isr84:
	cli
	push 0
	push 84
	jmp isr_common

global isr85
isr85:
	cli
	push 0
	push 85
	jmp isr_common

global isr86
isr86:
	cli
	push 0
	push 86
	jmp isr_common

global isr87
isr87:
	cli
	push 0
	push 87
	jmp isr_common

global isr88
isr88:
	cli
	push 0
	push 88
	jmp isr_common

global isr89
isr89:
	cli
	push 0
	push 89
	jmp isr_common

global isr90
isr90:
	cli
	push 0
	push 90
	jmp isr_common

global isr91
isr91:
	cli
	push 0
	push 91
	jmp isr_common

global isr92
isr92:
	cli
	push 0
	push 92
	jmp isr_common

global isr93
isr93:
	cli
	push 0
	push 93
	jmp isr_common

global isr94
isr94:
	cli
	push 0
	push 94
	jmp isr_common

global isr95
isr95:
	cli
	push 0
	push 95
	jmp isr_common

global isr96
isr96:
	cli
	push 0
	push 96
	jmp isr_common

global isr97
isr97:
	cli
	push 0
	push 97
	jmp isr_common

global isr98
isr98:
	cli
	push 0
	push 98
	jmp isr_common

global isr99
isr99:
	cli
	push 0
	push 99
	jmp isr_common

global isr100
isr100:
	cli
	push 0
	push 100
	jmp isr_common

global isr101
isr101:
	cli
	push 0
	push 101
	jmp isr_common

global isr102
isr102:
	cli
	push 0
	push 102
	jmp isr_common

global isr103
isr103:
	cli
	push 0
	push 103
	jmp isr_common

global isr104
isr104:
	cli
	push 0
	push 104
	jmp isr_common

global isr105
isr105:
	cli
	push 0
	push 105
	jmp isr_common

global isr106
isr106:
	cli
	push 0
	push 106
	jmp isr_common

global isr107
isr107:
	cli
	push 0
	push 107
	jmp isr_common

global isr108
isr108:
	cli
	push 0
	push 108
	jmp isr_common

global isr109
isr109:
	cli
	push 0
	push 109
	jmp isr_common

global isr110
isr110:
	cli
	push 0
	push 110
	jmp isr_common

global isr111
isr111:
	cli
	push 0
	push 111
	jmp isr_common

global isr112
isr112:
	cli
	push 0
	push 112
	jmp isr_common

global isr113
isr113:
	cli
	push 0
	push 113
	jmp isr_common

global isr114
isr114:
	cli
	push 0
	push 114
	jmp isr_common

global isr115
isr115:
	cli
	push 0
	push 115
	jmp isr_common

global isr116
isr116:
	cli
	push 0
	push 116
	jmp isr_common

global isr117
isr117:
	cli
	push 0
	push 117
	jmp isr_common

global isr118
isr118:
	cli
	push 0
	push 118
	jmp isr_common

global isr119
isr119:
	cli
	push 0
	push 119
	jmp isr_common

global isr120
isr120:
	cli
	push 0
	push 120
	jmp isr_common

global isr121
isr121:
	cli
	push 0
	push 121
	jmp isr_common

global isr122
isr122:
	cli
	push 0
	push 122
	jmp isr_common

global isr123
isr123:
	cli
	push 0
	push 123
	jmp isr_common

global isr124
isr124:
	cli
	push 0
	push 124
	jmp isr_common

global isr125
isr125:
	cli
	push 0
	push 125
	jmp isr_common

global isr126
isr126:
	cli
	push 0
	push 126
	jmp isr_common

global isr127
isr127:
	cli
	push 0
	push 127
	jmp isr_common

global isr128
isr128:
	cli
	push 0
	push 128
	jmp isr_common

global isr129
isr129:
	cli
	push 0
	push 129
	jmp isr_common

global isr130
isr130:
	cli
	push 0
	push 130
	jmp isr_common

global isr131
isr131:
	cli
	push 0
	push 131
	jmp isr_common

global isr132
isr132:
	cli
	push 0
	push 132
	jmp isr_common

global isr133
isr133:
	cli
	push 0
	push 133
	jmp isr_common

global isr134
isr134:
	cli
	push 0
	push 134
	jmp isr_common

global isr135
isr135:
	cli
	push 0
	push 135
	jmp isr_common

global isr136
isr136:
	cli
	push 0
	push 136
	jmp isr_common

global isr137
isr137:
	cli
	push 0
	push 137
	jmp isr_common

global isr138
isr138:
	cli
	push 0
	push 138
	jmp isr_common

global isr139
isr139:
	cli
	push 0
	push 139
	jmp isr_common

global isr140
isr140:
	cli
	push 0
	push 140
	jmp isr_common

global isr141
isr141:
	cli
	push 0
	push 141
	jmp isr_common

global isr142
isr142:
	cli
	push 0
	push 142
	jmp isr_common

global isr143
isr143:
	cli
	push 0
	push 143
	jmp isr_common

global isr144
isr144:
	cli
	push 0
	push 144
	jmp isr_common

global isr145
isr145:
	cli
	push 0
	push 145
	jmp isr_common

global isr146
isr146:
	cli
	push 0
	push 146
	jmp isr_common

global isr147
isr147:
	cli
	push 0
	push 147
	jmp isr_common

global isr148
isr148:
	cli
	push 0
	push 148
	jmp isr_common

global isr149
isr149:
	cli
	push 0
	push 149
	jmp isr_common

global isr150
isr150:
	cli
	push 0
	push 150
	jmp isr_common

global isr151
isr151:
	cli
	push 0
	push 151
	jmp isr_common

global isr152
isr152:
	cli
	push 0
	push 152
	jmp isr_common

global isr153
isr153:
	cli
	push 0
	push 153
	jmp isr_common

global isr154
isr154:
	cli
	push 0
	push 154
	jmp isr_common

global isr155
isr155:
	cli
	push 0
	push 155
	jmp isr_common

global isr156
isr156:
	cli
	push 0
	push 156
	jmp isr_common

global isr157
isr157:
	cli
	push 0
	push 157
	jmp isr_common

global isr158
isr158:
	cli
	push 0
	push 158
	jmp isr_common

global isr159
isr159:
	cli
	push 0
	push 159
	jmp isr_common

global isr160
isr160:
	cli
	push 0
	push 160
	jmp isr_common

global isr161
isr161:
	cli
	push 0
	push 161
	jmp isr_common

global isr162
isr162:
	cli
	push 0
	push 162
	jmp isr_common

global isr163
isr163:
	cli
	push 0
	push 163
	jmp isr_common

global isr164
isr164:
	cli
	push 0
	push 164
	jmp isr_common

global isr165
isr165:
	cli
	push 0
	push 165
	jmp isr_common

global isr166
isr166:
	cli
	push 0
	push 166
	jmp isr_common

global isr167
isr167:
	cli
	push 0
	push 167
	jmp isr_common

global isr168
isr168:
	cli
	push 0
	push 168
	jmp isr_common

global isr169
isr169:
	cli
	push 0
	push 169
	jmp isr_common

global isr170
isr170:
	cli
	push 0
	push 170
	jmp isr_common

global isr171
isr171:
	cli
	push 0
	push 171
	jmp isr_common

global isr172
isr172:
	cli
	push 0
	push 172
	jmp isr_common

global isr173
isr173:
	cli
	push 0
	push 173
	jmp isr_common

global isr174
isr174:
	cli
	push 0
	push 174
	jmp isr_common

global isr175
isr175:
	cli
	push 0
	push 175
	jmp isr_common

global isr176
isr176:
	cli
	push 0
	push 176
	jmp isr_common

global isr177
isr177:
	cli
	push 0
	push 177
	jmp isr_common

global isr178
isr178:
	cli
	push 0
	push 178
	jmp isr_common

global isr179
isr179:
	cli
	push 0
	push 179
	jmp isr_common

global isr180
isr180:
	cli
	push 0
	push 180
	jmp isr_common

global isr181
isr181:
	cli
	push 0
	push 181
	jmp isr_common

global isr182
isr182:
	cli
	push 0
	push 182
	jmp isr_common

global isr183
isr183:
	cli
	push 0
	push 183
	jmp isr_common

global isr184
isr184:
	cli
	push 0
	push 184
	jmp isr_common

global isr185
isr185:
	cli
	push 0
	push 185
	jmp isr_common

global isr186
isr186:
	cli
	push 0
	push 186
	jmp isr_common

global isr187
isr187:
	cli
	push 0
	push 187
	jmp isr_common

global isr188
isr188:
	cli
	push 0
	push 188
	jmp isr_common

global isr189
isr189:
	cli
	push 0
	push 189
	jmp isr_common

global isr190
isr190:
	cli
	push 0
	push 190
	jmp isr_common

global isr191
isr191:
	cli
	push 0
	push 191
	jmp isr_common

global isr192
isr192:
	cli
	push 0
	push 192
	jmp isr_common

global isr193
isr193:
	cli
	push 0
	push 193
	jmp isr_common

global isr194
isr194:
	cli
	push 0
	push 194
	jmp isr_common

global isr195
isr195:
	cli
	push 0
	push 195
	jmp isr_common

global isr196
isr196:
	cli
	push 0
	push 196
	jmp isr_common

global isr197
isr197:
	cli
	push 0
	push 197
	jmp isr_common

global isr198
isr198:
	cli
	push 0
	push 198
	jmp isr_common

global isr199
isr199:
	cli
	push 0
	push 199
	jmp isr_common

global isr200
isr200:
	cli
	push 0
	push 200
	jmp isr_common

global isr201
isr201:
	cli
	push 0
	push 201
	jmp isr_common

global isr202
isr202:
	cli
	push 0
	push 202
	jmp isr_common

global isr203
isr203:
	cli
	push 0
	push 203
	jmp isr_common

global isr204
isr204:
	cli
	push 0
	push 204
	jmp isr_common

global isr205
isr205:
	cli
	push 0
	push 205
	jmp isr_common

global isr206
isr206:
	cli
	push 0
	push 206
	jmp isr_common

global isr207
isr207:
	cli
	push 0
	push 207
	jmp isr_common

global isr208
isr208:
	cli
	push 0
	push 208
	jmp isr_common

global isr209
isr209:
	cli
	push 0
	push 209
	jmp isr_common

global isr210
isr210:
	cli
	push 0
	push 210
	jmp isr_common

global isr211
isr211:
	cli
	push 0
	push 211
	jmp isr_common

global isr212
isr212:
	cli
	push 0
	push 212
	jmp isr_common

global isr213
isr213:
	cli
	push 0
	push 213
	jmp isr_common

global isr214
isr214:
	cli
	push 0
	push 214
	jmp isr_common

global isr215
isr215:
	cli
	push 0
	push 215
	jmp isr_common

global isr216
isr216:
	cli
	push 0
	push 216
	jmp isr_common

global isr217
isr217:
	cli
	push 0
	push 217
	jmp isr_common

global isr218
isr218:
	cli
	push 0
	push 218
	jmp isr_common

global isr219
isr219:
	cli
	push 0
	push 219
	jmp isr_common

global isr220
isr220:
	cli
	push 0
	push 220
	jmp isr_common

global isr221
isr221:
	cli
	push 0
	push 221
	jmp isr_common

global isr222
isr222:
	cli
	push 0
	push 222
	jmp isr_common

global isr223
isr223:
	cli
	push 0
	push 223
	jmp isr_common

global isr224
isr224:
	cli
	push 0
	push 224
	jmp isr_common

global isr225
isr225:
	cli
	push 0
	push 225
	jmp isr_common

global isr226
isr226:
	cli
	push 0
	push 226
	jmp isr_common

global isr227
isr227:
	cli
	push 0
	push 227
	jmp isr_common

global isr228
isr228:
	cli
	push 0
	push 228
	jmp isr_common

global isr229
isr229:
	cli
	push 0
	push 229
	jmp isr_common

global isr230
isr230:
	cli
	push 0
	push 230
	jmp isr_common

global isr231
isr231:
	cli
	push 0
	push 231
	jmp isr_common

global isr232
isr232:
	cli
	push 0
	push 232
	jmp isr_common

global isr233
isr233:
	cli
	push 0
	push 233
	jmp isr_common

global isr234
isr234:
	cli
	push 0
	push 234
	jmp isr_common

global isr235
isr235:
	cli
	push 0
	push 235
	jmp isr_common

global isr236
isr236:
	cli
	push 0
	push 236
	jmp isr_common

global isr237
isr237:
	cli
	push 0
	push 237
	jmp isr_common

global isr238
isr238:
	cli
	push 0
	push 238
	jmp isr_common

global isr239
isr239:
	cli
	push 0
	push 239
	jmp isr_common

global isr240
isr240:
	cli
	push 0
	push 240
	jmp isr_common

global isr241
isr241:
	cli
	push 0
	push 241
	jmp isr_common

global isr242
isr242:
	cli
	push 0
	push 242
	jmp isr_common

global isr243
isr243:
	cli
	push 0
	push 243
	jmp isr_common

global isr244
isr244:
	cli
	push 0
	push 244
	jmp isr_common

global isr245
isr245:
	cli
	push 0
	push 245
	jmp isr_common

global isr246
isr246:
	cli
	push 0
	push 246
	jmp isr_common

global isr247
isr247:
	cli
	push 0
	push 247
	jmp isr_common

global isr248
isr248:
	cli
	push 0
	push 248
	jmp isr_common

global isr249
isr249:
	cli
	push 0
	push 249
	jmp isr_common

global isr250
isr250:
	cli
	push 0
	push 250
	jmp isr_common

global isr251
isr251:
	cli
	push 0
	push 251
	jmp isr_common

global isr252
isr252:
	cli
	push 0
	push 252
	jmp isr_common

global isr253
isr253:
	cli
	push 0
	push 253
	jmp isr_common

global isr254
isr254:
	cli
	push 0
	push 254
	jmp isr_common

global isr255
isr255:
	cli
	push 0
	push 255
	jmp isr_common

section .data
global isr_table
isr_table:
	dd isr0
	dd isr1
	dd isr2
	dd isr3
	dd isr4
	dd isr5
	dd isr6
	dd isr7
	dd isr8
	dd isr9
	dd isr10
	dd isr11
	dd isr12
	dd isr13
	dd isr14
	dd isr15
	dd isr16
	dd isr17
	dd isr18
	dd isr19
	dd isr20
	dd isr21
	dd isr22
	dd isr23
	dd isr24
	dd isr25
	dd isr26
	dd isr27
	dd isr28
	dd isr29
	dd isr30
	dd isr31
	dd isr32
	dd isr33
	dd isr34
	dd isr35
	dd isr36
	dd isr37
	dd isr38
	dd isr39
	dd isr40
	dd isr41
	dd isr42
	dd isr43
	dd isr44
	dd isr45
	dd isr46
	dd isr47
	dd isr48
	dd isr49
	dd isr50
	dd isr51
	dd isr52
	dd isr53
	dd isr54
	dd isr55
	dd isr56
	dd isr57
	dd isr58
	dd isr59
	dd isr60
	dd isr61
	dd isr62
	dd isr63
	dd isr64
	dd isr65
	dd isr66
	dd isr67
	dd isr68
	dd isr69
	dd isr70
	dd isr71
	dd isr72
	dd isr73
	dd isr74
	dd isr75
	dd isr76
	dd isr77
	dd isr78
	dd isr79
	dd isr80
	dd isr81
	dd isr82
	dd isr83
	dd isr84
	dd isr85
	dd isr86
	dd isr87
	dd isr88
	dd isr89
	dd isr90
	dd isr91
	dd isr92
	dd isr93
	dd isr94
	dd isr95
	dd isr96
	dd isr97
	dd isr98
	dd isr99
	dd isr100
	dd isr101
	dd isr102
	dd isr103
	dd isr104
	dd isr105
	dd isr106
	dd isr107
	dd isr108
	dd isr109
	dd isr110
	dd isr111
	dd isr112
	dd isr113
	dd isr114
	dd isr115
	dd isr116
	dd isr117
	dd isr118
	dd isr119
	dd isr120
	dd isr121
	dd isr122
	dd isr123
	dd isr124
	dd isr125
	dd isr126
	dd isr127
	dd isr128
	dd isr129
	dd isr130
	dd isr131
	dd isr132
	dd isr133
	dd isr134
	dd isr135
	dd isr136
	dd isr137
	dd isr138
	dd isr139
	dd isr140
	dd isr141
	dd isr142
	dd isr143
	dd isr144
	dd isr145
	dd isr146
	dd isr147
	dd isr148
	dd isr149
	dd isr150
	dd isr151
	dd isr152
	dd isr153
	dd isr154
	dd isr155
	dd isr156
	dd isr157
	dd isr158
	dd isr159
	dd isr160
	dd isr161
	dd isr162
	dd isr163
	dd isr164
	dd isr165
	dd isr166
	dd isr167
	dd isr168
	dd isr169
	dd isr170
	dd isr171
	dd isr172
	dd isr173
	dd isr174
	dd isr175
	dd isr176
	dd isr177
	dd isr178
	dd isr179
	dd isr180
	dd isr181
	dd isr182
	dd isr183
	dd isr184
	dd isr185
	dd isr186
	dd isr187
	dd isr188
	dd isr189
	dd isr190
	dd isr191
	dd isr192
	dd isr193
	dd isr194
	dd isr195
	dd isr196
	dd isr197
	dd isr198
	dd isr199
	dd isr200
	dd isr201
	dd isr202
	dd isr203
	dd isr204
	dd isr205
	dd isr206
	dd isr207
	dd isr208
	dd isr209
	dd isr210
	dd isr211
	dd isr212
	dd isr213
	dd isr214
	dd isr215
	dd isr216
	dd isr217
	dd isr218
	dd isr219
	dd isr220
	dd isr221
	dd isr222
	dd isr223
	dd isr224
	dd isr225
	dd isr226
	dd isr227
	dd isr228
	dd isr229
	dd isr230
	dd isr231
	dd isr232
	dd isr233
	dd isr234
	dd isr235
	dd isr236
	dd isr237
	dd isr238
	dd isr239
	dd isr240
	dd isr241
	dd isr242
	dd isr243
	dd isr244
	dd isr245
	dd isr246
	dd isr247
	dd isr248
	dd isr249
	dd isr250
	dd isr251
	dd isr252
	dd isr253
	dd isr254
	dd isr255
