??
??
B
AssignVariableOp
resource
value"dtype"
dtypetype?
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(?

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype?
E
Relu
features"T
activations"T"
Ttype:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
0
Sigmoid
x"T
y"T"
Ttype:

2
?
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ??
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
?
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 ?"serve*2.7.02v2.7.0-rc1-69-gc256c071bb28??	
n
	x1/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*
shared_name	x1/kernel
g
x1/kernel/Read/ReadVariableOpReadVariableOp	x1/kernel*
_output_shapes

:@*
dtype0
f
x1/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_name	x1/bias
_
x1/bias/Read/ReadVariableOpReadVariableOpx1/bias*
_output_shapes
:@*
dtype0
n
	x2/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*
shared_name	x2/kernel
g
x2/kernel/Read/ReadVariableOpReadVariableOp	x2/kernel*
_output_shapes

:@@*
dtype0
f
x2/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_name	x2/bias
_
x2/bias/Read/ReadVariableOpReadVariableOpx2/bias*
_output_shapes
:@*
dtype0
p

x3a/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*
shared_name
x3a/kernel
i
x3a/kernel/Read/ReadVariableOpReadVariableOp
x3a/kernel*
_output_shapes

:@@*
dtype0
h
x3a/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_name
x3a/bias
a
x3a/bias/Read/ReadVariableOpReadVariableOpx3a/bias*
_output_shapes
:@*
dtype0
p

x3b/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*
shared_name
x3b/kernel
i
x3b/kernel/Read/ReadVariableOpReadVariableOp
x3b/kernel*
_output_shapes

:@@*
dtype0
h
x3b/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_name
x3b/bias
a
x3b/bias/Read/ReadVariableOpReadVariableOpx3b/bias*
_output_shapes
:@*
dtype0
p

x3c/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*
shared_name
x3c/kernel
i
x3c/kernel/Read/ReadVariableOpReadVariableOp
x3c/kernel*
_output_shapes

:@@*
dtype0
h
x3c/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_name
x3c/bias
a
x3c/bias/Read/ReadVariableOpReadVariableOpx3c/bias*
_output_shapes
:@*
dtype0
r
hout/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*
shared_namehout/kernel
k
hout/kernel/Read/ReadVariableOpReadVariableOphout/kernel*
_output_shapes

:@*
dtype0
j
	hout/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_name	hout/bias
c
hout/bias/Read/ReadVariableOpReadVariableOp	hout/bias*
_output_shapes
:*
dtype0
r
vout/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*
shared_namevout/kernel
k
vout/kernel/Read/ReadVariableOpReadVariableOpvout/kernel*
_output_shapes

:@*
dtype0
j
	vout/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_name	vout/bias
c
vout/bias/Read/ReadVariableOpReadVariableOp	vout/bias*
_output_shapes
:*
dtype0
r
lout/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*
shared_namelout/kernel
k
lout/kernel/Read/ReadVariableOpReadVariableOplout/kernel*
_output_shapes

:@*
dtype0
j
	lout/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_name	lout/bias
c
lout/bias/Read/ReadVariableOpReadVariableOp	lout/bias*
_output_shapes
:*
dtype0
f
	Adam/iterVarHandleOp*
_output_shapes
: *
dtype0	*
shape: *
shared_name	Adam/iter
_
Adam/iter/Read/ReadVariableOpReadVariableOp	Adam/iter*
_output_shapes
: *
dtype0	
j
Adam/beta_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameAdam/beta_1
c
Adam/beta_1/Read/ReadVariableOpReadVariableOpAdam/beta_1*
_output_shapes
: *
dtype0
j
Adam/beta_2VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameAdam/beta_2
c
Adam/beta_2/Read/ReadVariableOpReadVariableOpAdam/beta_2*
_output_shapes
: *
dtype0
h

Adam/decayVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name
Adam/decay
a
Adam/decay/Read/ReadVariableOpReadVariableOp
Adam/decay*
_output_shapes
: *
dtype0
x
Adam/learning_rateVarHandleOp*
_output_shapes
: *
dtype0*
shape: *#
shared_nameAdam/learning_rate
q
&Adam/learning_rate/Read/ReadVariableOpReadVariableOpAdam/learning_rate*
_output_shapes
: *
dtype0
^
totalVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nametotal
W
total/Read/ReadVariableOpReadVariableOptotal*
_output_shapes
: *
dtype0
^
countVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namecount
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
b
total_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_1
[
total_1/Read/ReadVariableOpReadVariableOptotal_1*
_output_shapes
: *
dtype0
b
count_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_1
[
count_1/Read/ReadVariableOpReadVariableOpcount_1*
_output_shapes
: *
dtype0
b
total_2VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_2
[
total_2/Read/ReadVariableOpReadVariableOptotal_2*
_output_shapes
: *
dtype0
b
count_2VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_2
[
count_2/Read/ReadVariableOpReadVariableOpcount_2*
_output_shapes
: *
dtype0
b
total_3VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_3
[
total_3/Read/ReadVariableOpReadVariableOptotal_3*
_output_shapes
: *
dtype0
b
count_3VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_3
[
count_3/Read/ReadVariableOpReadVariableOpcount_3*
_output_shapes
: *
dtype0
|
Adam/x1/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*!
shared_nameAdam/x1/kernel/m
u
$Adam/x1/kernel/m/Read/ReadVariableOpReadVariableOpAdam/x1/kernel/m*
_output_shapes

:@*
dtype0
t
Adam/x1/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_nameAdam/x1/bias/m
m
"Adam/x1/bias/m/Read/ReadVariableOpReadVariableOpAdam/x1/bias/m*
_output_shapes
:@*
dtype0
|
Adam/x2/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*!
shared_nameAdam/x2/kernel/m
u
$Adam/x2/kernel/m/Read/ReadVariableOpReadVariableOpAdam/x2/kernel/m*
_output_shapes

:@@*
dtype0
t
Adam/x2/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_nameAdam/x2/bias/m
m
"Adam/x2/bias/m/Read/ReadVariableOpReadVariableOpAdam/x2/bias/m*
_output_shapes
:@*
dtype0
~
Adam/x3a/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*"
shared_nameAdam/x3a/kernel/m
w
%Adam/x3a/kernel/m/Read/ReadVariableOpReadVariableOpAdam/x3a/kernel/m*
_output_shapes

:@@*
dtype0
v
Adam/x3a/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:@* 
shared_nameAdam/x3a/bias/m
o
#Adam/x3a/bias/m/Read/ReadVariableOpReadVariableOpAdam/x3a/bias/m*
_output_shapes
:@*
dtype0
~
Adam/x3b/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*"
shared_nameAdam/x3b/kernel/m
w
%Adam/x3b/kernel/m/Read/ReadVariableOpReadVariableOpAdam/x3b/kernel/m*
_output_shapes

:@@*
dtype0
v
Adam/x3b/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:@* 
shared_nameAdam/x3b/bias/m
o
#Adam/x3b/bias/m/Read/ReadVariableOpReadVariableOpAdam/x3b/bias/m*
_output_shapes
:@*
dtype0
~
Adam/x3c/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*"
shared_nameAdam/x3c/kernel/m
w
%Adam/x3c/kernel/m/Read/ReadVariableOpReadVariableOpAdam/x3c/kernel/m*
_output_shapes

:@@*
dtype0
v
Adam/x3c/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:@* 
shared_nameAdam/x3c/bias/m
o
#Adam/x3c/bias/m/Read/ReadVariableOpReadVariableOpAdam/x3c/bias/m*
_output_shapes
:@*
dtype0
?
Adam/hout/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*#
shared_nameAdam/hout/kernel/m
y
&Adam/hout/kernel/m/Read/ReadVariableOpReadVariableOpAdam/hout/kernel/m*
_output_shapes

:@*
dtype0
x
Adam/hout/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:*!
shared_nameAdam/hout/bias/m
q
$Adam/hout/bias/m/Read/ReadVariableOpReadVariableOpAdam/hout/bias/m*
_output_shapes
:*
dtype0
?
Adam/vout/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*#
shared_nameAdam/vout/kernel/m
y
&Adam/vout/kernel/m/Read/ReadVariableOpReadVariableOpAdam/vout/kernel/m*
_output_shapes

:@*
dtype0
x
Adam/vout/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:*!
shared_nameAdam/vout/bias/m
q
$Adam/vout/bias/m/Read/ReadVariableOpReadVariableOpAdam/vout/bias/m*
_output_shapes
:*
dtype0
?
Adam/lout/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*#
shared_nameAdam/lout/kernel/m
y
&Adam/lout/kernel/m/Read/ReadVariableOpReadVariableOpAdam/lout/kernel/m*
_output_shapes

:@*
dtype0
x
Adam/lout/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:*!
shared_nameAdam/lout/bias/m
q
$Adam/lout/bias/m/Read/ReadVariableOpReadVariableOpAdam/lout/bias/m*
_output_shapes
:*
dtype0
|
Adam/x1/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*!
shared_nameAdam/x1/kernel/v
u
$Adam/x1/kernel/v/Read/ReadVariableOpReadVariableOpAdam/x1/kernel/v*
_output_shapes

:@*
dtype0
t
Adam/x1/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_nameAdam/x1/bias/v
m
"Adam/x1/bias/v/Read/ReadVariableOpReadVariableOpAdam/x1/bias/v*
_output_shapes
:@*
dtype0
|
Adam/x2/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*!
shared_nameAdam/x2/kernel/v
u
$Adam/x2/kernel/v/Read/ReadVariableOpReadVariableOpAdam/x2/kernel/v*
_output_shapes

:@@*
dtype0
t
Adam/x2/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:@*
shared_nameAdam/x2/bias/v
m
"Adam/x2/bias/v/Read/ReadVariableOpReadVariableOpAdam/x2/bias/v*
_output_shapes
:@*
dtype0
~
Adam/x3a/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*"
shared_nameAdam/x3a/kernel/v
w
%Adam/x3a/kernel/v/Read/ReadVariableOpReadVariableOpAdam/x3a/kernel/v*
_output_shapes

:@@*
dtype0
v
Adam/x3a/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:@* 
shared_nameAdam/x3a/bias/v
o
#Adam/x3a/bias/v/Read/ReadVariableOpReadVariableOpAdam/x3a/bias/v*
_output_shapes
:@*
dtype0
~
Adam/x3b/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*"
shared_nameAdam/x3b/kernel/v
w
%Adam/x3b/kernel/v/Read/ReadVariableOpReadVariableOpAdam/x3b/kernel/v*
_output_shapes

:@@*
dtype0
v
Adam/x3b/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:@* 
shared_nameAdam/x3b/bias/v
o
#Adam/x3b/bias/v/Read/ReadVariableOpReadVariableOpAdam/x3b/bias/v*
_output_shapes
:@*
dtype0
~
Adam/x3c/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@@*"
shared_nameAdam/x3c/kernel/v
w
%Adam/x3c/kernel/v/Read/ReadVariableOpReadVariableOpAdam/x3c/kernel/v*
_output_shapes

:@@*
dtype0
v
Adam/x3c/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:@* 
shared_nameAdam/x3c/bias/v
o
#Adam/x3c/bias/v/Read/ReadVariableOpReadVariableOpAdam/x3c/bias/v*
_output_shapes
:@*
dtype0
?
Adam/hout/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*#
shared_nameAdam/hout/kernel/v
y
&Adam/hout/kernel/v/Read/ReadVariableOpReadVariableOpAdam/hout/kernel/v*
_output_shapes

:@*
dtype0
x
Adam/hout/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:*!
shared_nameAdam/hout/bias/v
q
$Adam/hout/bias/v/Read/ReadVariableOpReadVariableOpAdam/hout/bias/v*
_output_shapes
:*
dtype0
?
Adam/vout/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*#
shared_nameAdam/vout/kernel/v
y
&Adam/vout/kernel/v/Read/ReadVariableOpReadVariableOpAdam/vout/kernel/v*
_output_shapes

:@*
dtype0
x
Adam/vout/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:*!
shared_nameAdam/vout/bias/v
q
$Adam/vout/bias/v/Read/ReadVariableOpReadVariableOpAdam/vout/bias/v*
_output_shapes
:*
dtype0
?
Adam/lout/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:@*#
shared_nameAdam/lout/kernel/v
y
&Adam/lout/kernel/v/Read/ReadVariableOpReadVariableOpAdam/lout/kernel/v*
_output_shapes

:@*
dtype0
x
Adam/lout/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:*!
shared_nameAdam/lout/bias/v
q
$Adam/lout/bias/v/Read/ReadVariableOpReadVariableOpAdam/lout/bias/v*
_output_shapes
:*
dtype0

NoOpNoOp
?S
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*?S
value?SB?S B?S
?
layer-0
layer_with_weights-0
layer-1
layer_with_weights-1
layer-2
layer_with_weights-2
layer-3
layer_with_weights-3
layer-4
layer_with_weights-4
layer-5
layer_with_weights-5
layer-6
layer_with_weights-6
layer-7
	layer_with_weights-7
	layer-8

	optimizer
loss
	variables
trainable_variables
regularization_losses
	keras_api

signatures
 
h

kernel
bias
	variables
trainable_variables
regularization_losses
	keras_api
h

kernel
bias
	variables
trainable_variables
regularization_losses
	keras_api
h

kernel
bias
	variables
 trainable_variables
!regularization_losses
"	keras_api
h

#kernel
$bias
%	variables
&trainable_variables
'regularization_losses
(	keras_api
h

)kernel
*bias
+	variables
,trainable_variables
-regularization_losses
.	keras_api
h

/kernel
0bias
1	variables
2trainable_variables
3regularization_losses
4	keras_api
h

5kernel
6bias
7	variables
8trainable_variables
9regularization_losses
:	keras_api
h

;kernel
<bias
=	variables
>trainable_variables
?regularization_losses
@	keras_api
?
Aiter

Bbeta_1

Cbeta_2
	Ddecay
Elearning_ratem?m?m?m?m?m?#m?$m?)m?*m?/m?0m?5m?6m?;m?<m?v?v?v?v?v?v?#v?$v?)v?*v?/v?0v?5v?6v?;v?<v?
 
v
0
1
2
3
4
5
#6
$7
)8
*9
/10
011
512
613
;14
<15
v
0
1
2
3
4
5
#6
$7
)8
*9
/10
011
512
613
;14
<15
 
?
Fnon_trainable_variables

Glayers
Hmetrics
Ilayer_regularization_losses
Jlayer_metrics
	variables
trainable_variables
regularization_losses
 
US
VARIABLE_VALUE	x1/kernel6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUE
QO
VARIABLE_VALUEx1/bias4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUE

0
1

0
1
 
?
Knon_trainable_variables

Llayers
Mmetrics
Nlayer_regularization_losses
Olayer_metrics
	variables
trainable_variables
regularization_losses
US
VARIABLE_VALUE	x2/kernel6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUE
QO
VARIABLE_VALUEx2/bias4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUE

0
1

0
1
 
?
Pnon_trainable_variables

Qlayers
Rmetrics
Slayer_regularization_losses
Tlayer_metrics
	variables
trainable_variables
regularization_losses
VT
VARIABLE_VALUE
x3a/kernel6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUE
RP
VARIABLE_VALUEx3a/bias4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUE

0
1

0
1
 
?
Unon_trainable_variables

Vlayers
Wmetrics
Xlayer_regularization_losses
Ylayer_metrics
	variables
 trainable_variables
!regularization_losses
VT
VARIABLE_VALUE
x3b/kernel6layer_with_weights-3/kernel/.ATTRIBUTES/VARIABLE_VALUE
RP
VARIABLE_VALUEx3b/bias4layer_with_weights-3/bias/.ATTRIBUTES/VARIABLE_VALUE

#0
$1

#0
$1
 
?
Znon_trainable_variables

[layers
\metrics
]layer_regularization_losses
^layer_metrics
%	variables
&trainable_variables
'regularization_losses
VT
VARIABLE_VALUE
x3c/kernel6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUE
RP
VARIABLE_VALUEx3c/bias4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUE

)0
*1

)0
*1
 
?
_non_trainable_variables

`layers
ametrics
blayer_regularization_losses
clayer_metrics
+	variables
,trainable_variables
-regularization_losses
WU
VARIABLE_VALUEhout/kernel6layer_with_weights-5/kernel/.ATTRIBUTES/VARIABLE_VALUE
SQ
VARIABLE_VALUE	hout/bias4layer_with_weights-5/bias/.ATTRIBUTES/VARIABLE_VALUE

/0
01

/0
01
 
?
dnon_trainable_variables

elayers
fmetrics
glayer_regularization_losses
hlayer_metrics
1	variables
2trainable_variables
3regularization_losses
WU
VARIABLE_VALUEvout/kernel6layer_with_weights-6/kernel/.ATTRIBUTES/VARIABLE_VALUE
SQ
VARIABLE_VALUE	vout/bias4layer_with_weights-6/bias/.ATTRIBUTES/VARIABLE_VALUE

50
61

50
61
 
?
inon_trainable_variables

jlayers
kmetrics
llayer_regularization_losses
mlayer_metrics
7	variables
8trainable_variables
9regularization_losses
WU
VARIABLE_VALUElout/kernel6layer_with_weights-7/kernel/.ATTRIBUTES/VARIABLE_VALUE
SQ
VARIABLE_VALUE	lout/bias4layer_with_weights-7/bias/.ATTRIBUTES/VARIABLE_VALUE

;0
<1

;0
<1
 
?
nnon_trainable_variables

olayers
pmetrics
qlayer_regularization_losses
rlayer_metrics
=	variables
>trainable_variables
?regularization_losses
HF
VARIABLE_VALUE	Adam/iter)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUE
LJ
VARIABLE_VALUEAdam/beta_1+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUE
LJ
VARIABLE_VALUEAdam/beta_2+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUE
JH
VARIABLE_VALUE
Adam/decay*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUE
ZX
VARIABLE_VALUEAdam/learning_rate2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUE
 
?
0
1
2
3
4
5
6
7
	8

s0
t1
u2
v3
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
4
	wtotal
	xcount
y	variables
z	keras_api
4
	{total
	|count
}	variables
~	keras_api
7
	total

?count
?	variables
?	keras_api
8

?total

?count
?	variables
?	keras_api
OM
VARIABLE_VALUEtotal4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE
OM
VARIABLE_VALUEcount4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE

w0
x1

y	variables
QO
VARIABLE_VALUEtotal_14keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUE
QO
VARIABLE_VALUEcount_14keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUE

{0
|1

}	variables
QO
VARIABLE_VALUEtotal_24keras_api/metrics/2/total/.ATTRIBUTES/VARIABLE_VALUE
QO
VARIABLE_VALUEcount_24keras_api/metrics/2/count/.ATTRIBUTES/VARIABLE_VALUE

0
?1

?	variables
QO
VARIABLE_VALUEtotal_34keras_api/metrics/3/total/.ATTRIBUTES/VARIABLE_VALUE
QO
VARIABLE_VALUEcount_34keras_api/metrics/3/count/.ATTRIBUTES/VARIABLE_VALUE

?0
?1

?	variables
xv
VARIABLE_VALUEAdam/x1/kernel/mRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
tr
VARIABLE_VALUEAdam/x1/bias/mPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
xv
VARIABLE_VALUEAdam/x2/kernel/mRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
tr
VARIABLE_VALUEAdam/x2/bias/mPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
yw
VARIABLE_VALUEAdam/x3a/kernel/mRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
us
VARIABLE_VALUEAdam/x3a/bias/mPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
yw
VARIABLE_VALUEAdam/x3b/kernel/mRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
us
VARIABLE_VALUEAdam/x3b/bias/mPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
yw
VARIABLE_VALUEAdam/x3c/kernel/mRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
us
VARIABLE_VALUEAdam/x3c/bias/mPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
zx
VARIABLE_VALUEAdam/hout/kernel/mRlayer_with_weights-5/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
vt
VARIABLE_VALUEAdam/hout/bias/mPlayer_with_weights-5/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
zx
VARIABLE_VALUEAdam/vout/kernel/mRlayer_with_weights-6/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
vt
VARIABLE_VALUEAdam/vout/bias/mPlayer_with_weights-6/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
zx
VARIABLE_VALUEAdam/lout/kernel/mRlayer_with_weights-7/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
vt
VARIABLE_VALUEAdam/lout/bias/mPlayer_with_weights-7/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
xv
VARIABLE_VALUEAdam/x1/kernel/vRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
tr
VARIABLE_VALUEAdam/x1/bias/vPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
xv
VARIABLE_VALUEAdam/x2/kernel/vRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
tr
VARIABLE_VALUEAdam/x2/bias/vPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
yw
VARIABLE_VALUEAdam/x3a/kernel/vRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
us
VARIABLE_VALUEAdam/x3a/bias/vPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
yw
VARIABLE_VALUEAdam/x3b/kernel/vRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
us
VARIABLE_VALUEAdam/x3b/bias/vPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
yw
VARIABLE_VALUEAdam/x3c/kernel/vRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
us
VARIABLE_VALUEAdam/x3c/bias/vPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
zx
VARIABLE_VALUEAdam/hout/kernel/vRlayer_with_weights-5/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
vt
VARIABLE_VALUEAdam/hout/bias/vPlayer_with_weights-5/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
zx
VARIABLE_VALUEAdam/vout/kernel/vRlayer_with_weights-6/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
vt
VARIABLE_VALUEAdam/vout/bias/vPlayer_with_weights-6/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
zx
VARIABLE_VALUEAdam/lout/kernel/vRlayer_with_weights-7/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
vt
VARIABLE_VALUEAdam/lout/bias/vPlayer_with_weights-7/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
v
serving_default_xinPlaceholder*'
_output_shapes
:?????????*
dtype0*
shape:?????????
?
StatefulPartitionedCallStatefulPartitionedCallserving_default_xin	x1/kernelx1/bias	x2/kernelx2/bias
x3c/kernelx3c/bias
x3b/kernelx3b/bias
x3a/kernelx3a/biaslout/kernel	lout/biasvout/kernel	vout/biashout/kernel	hout/bias*
Tin
2*
Tout
2*
_collective_manager_ids
 *M
_output_shapes;
9:?????????:?????????:?????????*2
_read_only_resource_inputs
	
*0
config_proto 

CPU

GPU2*0J 8? *-
f(R&
$__inference_signature_wrapper_174364
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
?
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filenamex1/kernel/Read/ReadVariableOpx1/bias/Read/ReadVariableOpx2/kernel/Read/ReadVariableOpx2/bias/Read/ReadVariableOpx3a/kernel/Read/ReadVariableOpx3a/bias/Read/ReadVariableOpx3b/kernel/Read/ReadVariableOpx3b/bias/Read/ReadVariableOpx3c/kernel/Read/ReadVariableOpx3c/bias/Read/ReadVariableOphout/kernel/Read/ReadVariableOphout/bias/Read/ReadVariableOpvout/kernel/Read/ReadVariableOpvout/bias/Read/ReadVariableOplout/kernel/Read/ReadVariableOplout/bias/Read/ReadVariableOpAdam/iter/Read/ReadVariableOpAdam/beta_1/Read/ReadVariableOpAdam/beta_2/Read/ReadVariableOpAdam/decay/Read/ReadVariableOp&Adam/learning_rate/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOptotal_1/Read/ReadVariableOpcount_1/Read/ReadVariableOptotal_2/Read/ReadVariableOpcount_2/Read/ReadVariableOptotal_3/Read/ReadVariableOpcount_3/Read/ReadVariableOp$Adam/x1/kernel/m/Read/ReadVariableOp"Adam/x1/bias/m/Read/ReadVariableOp$Adam/x2/kernel/m/Read/ReadVariableOp"Adam/x2/bias/m/Read/ReadVariableOp%Adam/x3a/kernel/m/Read/ReadVariableOp#Adam/x3a/bias/m/Read/ReadVariableOp%Adam/x3b/kernel/m/Read/ReadVariableOp#Adam/x3b/bias/m/Read/ReadVariableOp%Adam/x3c/kernel/m/Read/ReadVariableOp#Adam/x3c/bias/m/Read/ReadVariableOp&Adam/hout/kernel/m/Read/ReadVariableOp$Adam/hout/bias/m/Read/ReadVariableOp&Adam/vout/kernel/m/Read/ReadVariableOp$Adam/vout/bias/m/Read/ReadVariableOp&Adam/lout/kernel/m/Read/ReadVariableOp$Adam/lout/bias/m/Read/ReadVariableOp$Adam/x1/kernel/v/Read/ReadVariableOp"Adam/x1/bias/v/Read/ReadVariableOp$Adam/x2/kernel/v/Read/ReadVariableOp"Adam/x2/bias/v/Read/ReadVariableOp%Adam/x3a/kernel/v/Read/ReadVariableOp#Adam/x3a/bias/v/Read/ReadVariableOp%Adam/x3b/kernel/v/Read/ReadVariableOp#Adam/x3b/bias/v/Read/ReadVariableOp%Adam/x3c/kernel/v/Read/ReadVariableOp#Adam/x3c/bias/v/Read/ReadVariableOp&Adam/hout/kernel/v/Read/ReadVariableOp$Adam/hout/bias/v/Read/ReadVariableOp&Adam/vout/kernel/v/Read/ReadVariableOp$Adam/vout/bias/v/Read/ReadVariableOp&Adam/lout/kernel/v/Read/ReadVariableOp$Adam/lout/bias/v/Read/ReadVariableOpConst*J
TinC
A2?	*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *(
f#R!
__inference__traced_save_174932
?	
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filename	x1/kernelx1/bias	x2/kernelx2/bias
x3a/kernelx3a/bias
x3b/kernelx3b/bias
x3c/kernelx3c/biashout/kernel	hout/biasvout/kernel	vout/biaslout/kernel	lout/bias	Adam/iterAdam/beta_1Adam/beta_2
Adam/decayAdam/learning_ratetotalcounttotal_1count_1total_2count_2total_3count_3Adam/x1/kernel/mAdam/x1/bias/mAdam/x2/kernel/mAdam/x2/bias/mAdam/x3a/kernel/mAdam/x3a/bias/mAdam/x3b/kernel/mAdam/x3b/bias/mAdam/x3c/kernel/mAdam/x3c/bias/mAdam/hout/kernel/mAdam/hout/bias/mAdam/vout/kernel/mAdam/vout/bias/mAdam/lout/kernel/mAdam/lout/bias/mAdam/x1/kernel/vAdam/x1/bias/vAdam/x2/kernel/vAdam/x2/bias/vAdam/x3a/kernel/vAdam/x3a/bias/vAdam/x3b/kernel/vAdam/x3b/bias/vAdam/x3c/kernel/vAdam/x3c/bias/vAdam/hout/kernel/vAdam/hout/bias/vAdam/vout/kernel/vAdam/vout/bias/vAdam/lout/kernel/vAdam/lout/bias/v*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8? *+
f&R$
"__inference__traced_restore_175125??
?
?
$__inference_x3b_layer_call_fn_174635

inputs
unknown:@@
	unknown_0:@
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3b_layer_call_and_return_conditional_losses_173860o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????@`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?
?
#__inference_x2_layer_call_fn_174595

inputs
unknown:@@
	unknown_0:@
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x2_layer_call_and_return_conditional_losses_173826o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????@`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?	
?
@__inference_vout_layer_call_and_return_conditional_losses_174705

inputs0
matmul_readvariableop_resource:@-
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?

?
>__inference_x2_layer_call_and_return_conditional_losses_174606

inputs0
matmul_readvariableop_resource:@@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?
?
&__inference_model_layer_call_fn_174405

inputs
unknown:@
	unknown_0:@
	unknown_1:@@
	unknown_2:@
	unknown_3:@@
	unknown_4:@
	unknown_5:@@
	unknown_6:@
	unknown_7:@@
	unknown_8:@
	unknown_9:@

unknown_10:

unknown_11:@

unknown_12:

unknown_13:@

unknown_14:
identity

identity_1

identity_2??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14*
Tin
2*
Tout
2*
_collective_manager_ids
 *M
_output_shapes;
9:?????????:?????????:?????????*2
_read_only_resource_inputs
	
*0
config_proto 

CPU

GPU2*0J 8? *J
fERC
A__inference_model_layer_call_and_return_conditional_losses_173935o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????q

Identity_1Identity StatefulPartitionedCall:output:1^NoOp*
T0*'
_output_shapes
:?????????q

Identity_2Identity StatefulPartitionedCall:output:2^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?

?
?__inference_x3b_layer_call_and_return_conditional_losses_173860

inputs0
matmul_readvariableop_resource:@@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?

?
>__inference_x1_layer_call_and_return_conditional_losses_173809

inputs0
matmul_readvariableop_resource:@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?	
?
@__inference_vout_layer_call_and_return_conditional_losses_173909

inputs0
matmul_readvariableop_resource:@-
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?
?
&__inference_model_layer_call_fn_173974
xin
unknown:@
	unknown_0:@
	unknown_1:@@
	unknown_2:@
	unknown_3:@@
	unknown_4:@
	unknown_5:@@
	unknown_6:@
	unknown_7:@@
	unknown_8:@
	unknown_9:@

unknown_10:

unknown_11:@

unknown_12:

unknown_13:@

unknown_14:
identity

identity_1

identity_2??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallxinunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14*
Tin
2*
Tout
2*
_collective_manager_ids
 *M
_output_shapes;
9:?????????:?????????:?????????*2
_read_only_resource_inputs
	
*0
config_proto 

CPU

GPU2*0J 8? *J
fERC
A__inference_model_layer_call_and_return_conditional_losses_173935o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????q

Identity_1Identity StatefulPartitionedCall:output:1^NoOp*
T0*'
_output_shapes
:?????????q

Identity_2Identity StatefulPartitionedCall:output:2^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:L H
'
_output_shapes
:?????????

_user_specified_namexin
?
?
&__inference_model_layer_call_fn_174446

inputs
unknown:@
	unknown_0:@
	unknown_1:@@
	unknown_2:@
	unknown_3:@@
	unknown_4:@
	unknown_5:@@
	unknown_6:@
	unknown_7:@@
	unknown_8:@
	unknown_9:@

unknown_10:

unknown_11:@

unknown_12:

unknown_13:@

unknown_14:
identity

identity_1

identity_2??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14*
Tin
2*
Tout
2*
_collective_manager_ids
 *M
_output_shapes;
9:?????????:?????????:?????????*2
_read_only_resource_inputs
	
*0
config_proto 

CPU

GPU2*0J 8? *J
fERC
A__inference_model_layer_call_and_return_conditional_losses_174143o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????q

Identity_1Identity StatefulPartitionedCall:output:1^NoOp*
T0*'
_output_shapes
:?????????q

Identity_2Identity StatefulPartitionedCall:output:2^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?G
?
!__inference__wrapped_model_173791
xin9
'model_x1_matmul_readvariableop_resource:@6
(model_x1_biasadd_readvariableop_resource:@9
'model_x2_matmul_readvariableop_resource:@@6
(model_x2_biasadd_readvariableop_resource:@:
(model_x3c_matmul_readvariableop_resource:@@7
)model_x3c_biasadd_readvariableop_resource:@:
(model_x3b_matmul_readvariableop_resource:@@7
)model_x3b_biasadd_readvariableop_resource:@:
(model_x3a_matmul_readvariableop_resource:@@7
)model_x3a_biasadd_readvariableop_resource:@;
)model_lout_matmul_readvariableop_resource:@8
*model_lout_biasadd_readvariableop_resource:;
)model_vout_matmul_readvariableop_resource:@8
*model_vout_biasadd_readvariableop_resource:;
)model_hout_matmul_readvariableop_resource:@8
*model_hout_biasadd_readvariableop_resource:
identity

identity_1

identity_2??!model/hout/BiasAdd/ReadVariableOp? model/hout/MatMul/ReadVariableOp?!model/lout/BiasAdd/ReadVariableOp? model/lout/MatMul/ReadVariableOp?!model/vout/BiasAdd/ReadVariableOp? model/vout/MatMul/ReadVariableOp?model/x1/BiasAdd/ReadVariableOp?model/x1/MatMul/ReadVariableOp?model/x2/BiasAdd/ReadVariableOp?model/x2/MatMul/ReadVariableOp? model/x3a/BiasAdd/ReadVariableOp?model/x3a/MatMul/ReadVariableOp? model/x3b/BiasAdd/ReadVariableOp?model/x3b/MatMul/ReadVariableOp? model/x3c/BiasAdd/ReadVariableOp?model/x3c/MatMul/ReadVariableOp?
model/x1/MatMul/ReadVariableOpReadVariableOp'model_x1_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0x
model/x1/MatMulMatMulxin&model/x1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@?
model/x1/BiasAdd/ReadVariableOpReadVariableOp(model_x1_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
model/x1/BiasAddBiasAddmodel/x1/MatMul:product:0'model/x1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@b
model/x1/ReluRelumodel/x1/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@?
model/x2/MatMul/ReadVariableOpReadVariableOp'model_x2_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?
model/x2/MatMulMatMulmodel/x1/Relu:activations:0&model/x2/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@?
model/x2/BiasAdd/ReadVariableOpReadVariableOp(model_x2_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
model/x2/BiasAddBiasAddmodel/x2/MatMul:product:0'model/x2/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@b
model/x2/ReluRelumodel/x2/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@?
model/x3c/MatMul/ReadVariableOpReadVariableOp(model_x3c_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?
model/x3c/MatMulMatMulmodel/x2/Relu:activations:0'model/x3c/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@?
 model/x3c/BiasAdd/ReadVariableOpReadVariableOp)model_x3c_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
model/x3c/BiasAddBiasAddmodel/x3c/MatMul:product:0(model/x3c/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@d
model/x3c/ReluRelumodel/x3c/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@?
model/x3b/MatMul/ReadVariableOpReadVariableOp(model_x3b_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?
model/x3b/MatMulMatMulmodel/x2/Relu:activations:0'model/x3b/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@?
 model/x3b/BiasAdd/ReadVariableOpReadVariableOp)model_x3b_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
model/x3b/BiasAddBiasAddmodel/x3b/MatMul:product:0(model/x3b/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@d
model/x3b/ReluRelumodel/x3b/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@?
model/x3a/MatMul/ReadVariableOpReadVariableOp(model_x3a_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?
model/x3a/MatMulMatMulmodel/x2/Relu:activations:0'model/x3a/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@?
 model/x3a/BiasAdd/ReadVariableOpReadVariableOp)model_x3a_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
model/x3a/BiasAddBiasAddmodel/x3a/MatMul:product:0(model/x3a/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@d
model/x3a/ReluRelumodel/x3a/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@?
 model/lout/MatMul/ReadVariableOpReadVariableOp)model_lout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
model/lout/MatMulMatMulmodel/x3c/Relu:activations:0(model/lout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
!model/lout/BiasAdd/ReadVariableOpReadVariableOp*model_lout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
model/lout/BiasAddBiasAddmodel/lout/MatMul:product:0)model/lout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
 model/vout/MatMul/ReadVariableOpReadVariableOp)model_vout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
model/vout/MatMulMatMulmodel/x3b/Relu:activations:0(model/vout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
!model/vout/BiasAdd/ReadVariableOpReadVariableOp*model_vout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
model/vout/BiasAddBiasAddmodel/vout/MatMul:product:0)model/vout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
 model/hout/MatMul/ReadVariableOpReadVariableOp)model_hout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
model/hout/MatMulMatMulmodel/x3a/Relu:activations:0(model/hout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
!model/hout/BiasAdd/ReadVariableOpReadVariableOp*model_hout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
model/hout/BiasAddBiasAddmodel/hout/MatMul:product:0)model/hout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????l
model/hout/SigmoidSigmoidmodel/hout/BiasAdd:output:0*
T0*'
_output_shapes
:?????????e
IdentityIdentitymodel/hout/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:?????????l

Identity_1Identitymodel/lout/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????l

Identity_2Identitymodel/vout/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp"^model/hout/BiasAdd/ReadVariableOp!^model/hout/MatMul/ReadVariableOp"^model/lout/BiasAdd/ReadVariableOp!^model/lout/MatMul/ReadVariableOp"^model/vout/BiasAdd/ReadVariableOp!^model/vout/MatMul/ReadVariableOp ^model/x1/BiasAdd/ReadVariableOp^model/x1/MatMul/ReadVariableOp ^model/x2/BiasAdd/ReadVariableOp^model/x2/MatMul/ReadVariableOp!^model/x3a/BiasAdd/ReadVariableOp ^model/x3a/MatMul/ReadVariableOp!^model/x3b/BiasAdd/ReadVariableOp ^model/x3b/MatMul/ReadVariableOp!^model/x3c/BiasAdd/ReadVariableOp ^model/x3c/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 2F
!model/hout/BiasAdd/ReadVariableOp!model/hout/BiasAdd/ReadVariableOp2D
 model/hout/MatMul/ReadVariableOp model/hout/MatMul/ReadVariableOp2F
!model/lout/BiasAdd/ReadVariableOp!model/lout/BiasAdd/ReadVariableOp2D
 model/lout/MatMul/ReadVariableOp model/lout/MatMul/ReadVariableOp2F
!model/vout/BiasAdd/ReadVariableOp!model/vout/BiasAdd/ReadVariableOp2D
 model/vout/MatMul/ReadVariableOp model/vout/MatMul/ReadVariableOp2B
model/x1/BiasAdd/ReadVariableOpmodel/x1/BiasAdd/ReadVariableOp2@
model/x1/MatMul/ReadVariableOpmodel/x1/MatMul/ReadVariableOp2B
model/x2/BiasAdd/ReadVariableOpmodel/x2/BiasAdd/ReadVariableOp2@
model/x2/MatMul/ReadVariableOpmodel/x2/MatMul/ReadVariableOp2D
 model/x3a/BiasAdd/ReadVariableOp model/x3a/BiasAdd/ReadVariableOp2B
model/x3a/MatMul/ReadVariableOpmodel/x3a/MatMul/ReadVariableOp2D
 model/x3b/BiasAdd/ReadVariableOp model/x3b/BiasAdd/ReadVariableOp2B
model/x3b/MatMul/ReadVariableOpmodel/x3b/MatMul/ReadVariableOp2D
 model/x3c/BiasAdd/ReadVariableOp model/x3c/BiasAdd/ReadVariableOp2B
model/x3c/MatMul/ReadVariableOpmodel/x3c/MatMul/ReadVariableOp:L H
'
_output_shapes
:?????????

_user_specified_namexin
?)
?
A__inference_model_layer_call_and_return_conditional_losses_173935

inputs
	x1_173810:@
	x1_173812:@
	x2_173827:@@
	x2_173829:@

x3c_173844:@@

x3c_173846:@

x3b_173861:@@

x3b_173863:@

x3a_173878:@@

x3a_173880:@
lout_173894:@
lout_173896:
vout_173910:@
vout_173912:
hout_173927:@
hout_173929:
identity

identity_1

identity_2??hout/StatefulPartitionedCall?lout/StatefulPartitionedCall?vout/StatefulPartitionedCall?x1/StatefulPartitionedCall?x2/StatefulPartitionedCall?x3a/StatefulPartitionedCall?x3b/StatefulPartitionedCall?x3c/StatefulPartitionedCall?
x1/StatefulPartitionedCallStatefulPartitionedCallinputs	x1_173810	x1_173812*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x1_layer_call_and_return_conditional_losses_173809?
x2/StatefulPartitionedCallStatefulPartitionedCall#x1/StatefulPartitionedCall:output:0	x2_173827	x2_173829*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x2_layer_call_and_return_conditional_losses_173826?
x3c/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3c_173844
x3c_173846*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3c_layer_call_and_return_conditional_losses_173843?
x3b/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3b_173861
x3b_173863*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3b_layer_call_and_return_conditional_losses_173860?
x3a/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3a_173878
x3a_173880*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3a_layer_call_and_return_conditional_losses_173877?
lout/StatefulPartitionedCallStatefulPartitionedCall$x3c/StatefulPartitionedCall:output:0lout_173894lout_173896*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_lout_layer_call_and_return_conditional_losses_173893?
vout/StatefulPartitionedCallStatefulPartitionedCall$x3b/StatefulPartitionedCall:output:0vout_173910vout_173912*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_vout_layer_call_and_return_conditional_losses_173909?
hout/StatefulPartitionedCallStatefulPartitionedCall$x3a/StatefulPartitionedCall:output:0hout_173927hout_173929*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_hout_layer_call_and_return_conditional_losses_173926t
IdentityIdentity%hout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????v

Identity_1Identity%vout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????v

Identity_2Identity%lout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp^hout/StatefulPartitionedCall^lout/StatefulPartitionedCall^vout/StatefulPartitionedCall^x1/StatefulPartitionedCall^x2/StatefulPartitionedCall^x3a/StatefulPartitionedCall^x3b/StatefulPartitionedCall^x3c/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 2<
hout/StatefulPartitionedCallhout/StatefulPartitionedCall2<
lout/StatefulPartitionedCalllout/StatefulPartitionedCall2<
vout/StatefulPartitionedCallvout/StatefulPartitionedCall28
x1/StatefulPartitionedCallx1/StatefulPartitionedCall28
x2/StatefulPartitionedCallx2/StatefulPartitionedCall2:
x3a/StatefulPartitionedCallx3a/StatefulPartitionedCall2:
x3b/StatefulPartitionedCallx3b/StatefulPartitionedCall2:
x3c/StatefulPartitionedCallx3c/StatefulPartitionedCall:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?)
?
A__inference_model_layer_call_and_return_conditional_losses_174143

inputs
	x1_174100:@
	x1_174102:@
	x2_174105:@@
	x2_174107:@

x3c_174110:@@

x3c_174112:@

x3b_174115:@@

x3b_174117:@

x3a_174120:@@

x3a_174122:@
lout_174125:@
lout_174127:
vout_174130:@
vout_174132:
hout_174135:@
hout_174137:
identity

identity_1

identity_2??hout/StatefulPartitionedCall?lout/StatefulPartitionedCall?vout/StatefulPartitionedCall?x1/StatefulPartitionedCall?x2/StatefulPartitionedCall?x3a/StatefulPartitionedCall?x3b/StatefulPartitionedCall?x3c/StatefulPartitionedCall?
x1/StatefulPartitionedCallStatefulPartitionedCallinputs	x1_174100	x1_174102*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x1_layer_call_and_return_conditional_losses_173809?
x2/StatefulPartitionedCallStatefulPartitionedCall#x1/StatefulPartitionedCall:output:0	x2_174105	x2_174107*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x2_layer_call_and_return_conditional_losses_173826?
x3c/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3c_174110
x3c_174112*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3c_layer_call_and_return_conditional_losses_173843?
x3b/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3b_174115
x3b_174117*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3b_layer_call_and_return_conditional_losses_173860?
x3a/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3a_174120
x3a_174122*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3a_layer_call_and_return_conditional_losses_173877?
lout/StatefulPartitionedCallStatefulPartitionedCall$x3c/StatefulPartitionedCall:output:0lout_174125lout_174127*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_lout_layer_call_and_return_conditional_losses_173893?
vout/StatefulPartitionedCallStatefulPartitionedCall$x3b/StatefulPartitionedCall:output:0vout_174130vout_174132*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_vout_layer_call_and_return_conditional_losses_173909?
hout/StatefulPartitionedCallStatefulPartitionedCall$x3a/StatefulPartitionedCall:output:0hout_174135hout_174137*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_hout_layer_call_and_return_conditional_losses_173926t
IdentityIdentity%hout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????v

Identity_1Identity%vout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????v

Identity_2Identity%lout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp^hout/StatefulPartitionedCall^lout/StatefulPartitionedCall^vout/StatefulPartitionedCall^x1/StatefulPartitionedCall^x2/StatefulPartitionedCall^x3a/StatefulPartitionedCall^x3b/StatefulPartitionedCall^x3c/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 2<
hout/StatefulPartitionedCallhout/StatefulPartitionedCall2<
lout/StatefulPartitionedCalllout/StatefulPartitionedCall2<
vout/StatefulPartitionedCallvout/StatefulPartitionedCall28
x1/StatefulPartitionedCallx1/StatefulPartitionedCall28
x2/StatefulPartitionedCallx2/StatefulPartitionedCall2:
x3a/StatefulPartitionedCallx3a/StatefulPartitionedCall2:
x3b/StatefulPartitionedCallx3b/StatefulPartitionedCall2:
x3c/StatefulPartitionedCallx3c/StatefulPartitionedCall:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
??
?"
"__inference__traced_restore_175125
file_prefix,
assignvariableop_x1_kernel:@(
assignvariableop_1_x1_bias:@.
assignvariableop_2_x2_kernel:@@(
assignvariableop_3_x2_bias:@/
assignvariableop_4_x3a_kernel:@@)
assignvariableop_5_x3a_bias:@/
assignvariableop_6_x3b_kernel:@@)
assignvariableop_7_x3b_bias:@/
assignvariableop_8_x3c_kernel:@@)
assignvariableop_9_x3c_bias:@1
assignvariableop_10_hout_kernel:@+
assignvariableop_11_hout_bias:1
assignvariableop_12_vout_kernel:@+
assignvariableop_13_vout_bias:1
assignvariableop_14_lout_kernel:@+
assignvariableop_15_lout_bias:'
assignvariableop_16_adam_iter:	 )
assignvariableop_17_adam_beta_1: )
assignvariableop_18_adam_beta_2: (
assignvariableop_19_adam_decay: 0
&assignvariableop_20_adam_learning_rate: #
assignvariableop_21_total: #
assignvariableop_22_count: %
assignvariableop_23_total_1: %
assignvariableop_24_count_1: %
assignvariableop_25_total_2: %
assignvariableop_26_count_2: %
assignvariableop_27_total_3: %
assignvariableop_28_count_3: 6
$assignvariableop_29_adam_x1_kernel_m:@0
"assignvariableop_30_adam_x1_bias_m:@6
$assignvariableop_31_adam_x2_kernel_m:@@0
"assignvariableop_32_adam_x2_bias_m:@7
%assignvariableop_33_adam_x3a_kernel_m:@@1
#assignvariableop_34_adam_x3a_bias_m:@7
%assignvariableop_35_adam_x3b_kernel_m:@@1
#assignvariableop_36_adam_x3b_bias_m:@7
%assignvariableop_37_adam_x3c_kernel_m:@@1
#assignvariableop_38_adam_x3c_bias_m:@8
&assignvariableop_39_adam_hout_kernel_m:@2
$assignvariableop_40_adam_hout_bias_m:8
&assignvariableop_41_adam_vout_kernel_m:@2
$assignvariableop_42_adam_vout_bias_m:8
&assignvariableop_43_adam_lout_kernel_m:@2
$assignvariableop_44_adam_lout_bias_m:6
$assignvariableop_45_adam_x1_kernel_v:@0
"assignvariableop_46_adam_x1_bias_v:@6
$assignvariableop_47_adam_x2_kernel_v:@@0
"assignvariableop_48_adam_x2_bias_v:@7
%assignvariableop_49_adam_x3a_kernel_v:@@1
#assignvariableop_50_adam_x3a_bias_v:@7
%assignvariableop_51_adam_x3b_kernel_v:@@1
#assignvariableop_52_adam_x3b_bias_v:@7
%assignvariableop_53_adam_x3c_kernel_v:@@1
#assignvariableop_54_adam_x3c_bias_v:@8
&assignvariableop_55_adam_hout_kernel_v:@2
$assignvariableop_56_adam_hout_bias_v:8
&assignvariableop_57_adam_vout_kernel_v:@2
$assignvariableop_58_adam_vout_bias_v:8
&assignvariableop_59_adam_lout_kernel_v:@2
$assignvariableop_60_adam_lout_bias_v:
identity_62??AssignVariableOp?AssignVariableOp_1?AssignVariableOp_10?AssignVariableOp_11?AssignVariableOp_12?AssignVariableOp_13?AssignVariableOp_14?AssignVariableOp_15?AssignVariableOp_16?AssignVariableOp_17?AssignVariableOp_18?AssignVariableOp_19?AssignVariableOp_2?AssignVariableOp_20?AssignVariableOp_21?AssignVariableOp_22?AssignVariableOp_23?AssignVariableOp_24?AssignVariableOp_25?AssignVariableOp_26?AssignVariableOp_27?AssignVariableOp_28?AssignVariableOp_29?AssignVariableOp_3?AssignVariableOp_30?AssignVariableOp_31?AssignVariableOp_32?AssignVariableOp_33?AssignVariableOp_34?AssignVariableOp_35?AssignVariableOp_36?AssignVariableOp_37?AssignVariableOp_38?AssignVariableOp_39?AssignVariableOp_4?AssignVariableOp_40?AssignVariableOp_41?AssignVariableOp_42?AssignVariableOp_43?AssignVariableOp_44?AssignVariableOp_45?AssignVariableOp_46?AssignVariableOp_47?AssignVariableOp_48?AssignVariableOp_49?AssignVariableOp_5?AssignVariableOp_50?AssignVariableOp_51?AssignVariableOp_52?AssignVariableOp_53?AssignVariableOp_54?AssignVariableOp_55?AssignVariableOp_56?AssignVariableOp_57?AssignVariableOp_58?AssignVariableOp_59?AssignVariableOp_6?AssignVariableOp_60?AssignVariableOp_7?AssignVariableOp_8?AssignVariableOp_9?!
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:>*
dtype0*?!
value?!B?!>B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-3/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-3/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-5/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-5/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-6/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-6/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-7/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-7/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/2/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/2/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/3/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/3/count/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-5/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-5/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-6/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-6/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-7/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-7/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-5/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-5/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-6/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-6/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-7/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-7/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH?
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:>*
dtype0*?
value?B?>B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B ?
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*?
_output_shapes?
?::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*L
dtypesB
@2>	[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOpAssignVariableOpassignvariableop_x1_kernelIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_1AssignVariableOpassignvariableop_1_x1_biasIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_2AssignVariableOpassignvariableop_2_x2_kernelIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_3AssignVariableOpassignvariableop_3_x2_biasIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_4AssignVariableOpassignvariableop_4_x3a_kernelIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_5AssignVariableOpassignvariableop_5_x3a_biasIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_6AssignVariableOpassignvariableop_6_x3b_kernelIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_7IdentityRestoreV2:tensors:7"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_7AssignVariableOpassignvariableop_7_x3b_biasIdentity_7:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_8IdentityRestoreV2:tensors:8"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_8AssignVariableOpassignvariableop_8_x3c_kernelIdentity_8:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_9IdentityRestoreV2:tensors:9"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_9AssignVariableOpassignvariableop_9_x3c_biasIdentity_9:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_10IdentityRestoreV2:tensors:10"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_10AssignVariableOpassignvariableop_10_hout_kernelIdentity_10:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_11IdentityRestoreV2:tensors:11"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_11AssignVariableOpassignvariableop_11_hout_biasIdentity_11:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_12IdentityRestoreV2:tensors:12"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_12AssignVariableOpassignvariableop_12_vout_kernelIdentity_12:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_13IdentityRestoreV2:tensors:13"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_13AssignVariableOpassignvariableop_13_vout_biasIdentity_13:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_14IdentityRestoreV2:tensors:14"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_14AssignVariableOpassignvariableop_14_lout_kernelIdentity_14:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_15IdentityRestoreV2:tensors:15"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_15AssignVariableOpassignvariableop_15_lout_biasIdentity_15:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_16IdentityRestoreV2:tensors:16"/device:CPU:0*
T0	*
_output_shapes
:?
AssignVariableOp_16AssignVariableOpassignvariableop_16_adam_iterIdentity_16:output:0"/device:CPU:0*
_output_shapes
 *
dtype0	_
Identity_17IdentityRestoreV2:tensors:17"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_17AssignVariableOpassignvariableop_17_adam_beta_1Identity_17:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_18IdentityRestoreV2:tensors:18"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_18AssignVariableOpassignvariableop_18_adam_beta_2Identity_18:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_19IdentityRestoreV2:tensors:19"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_19AssignVariableOpassignvariableop_19_adam_decayIdentity_19:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_20IdentityRestoreV2:tensors:20"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_20AssignVariableOp&assignvariableop_20_adam_learning_rateIdentity_20:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_21IdentityRestoreV2:tensors:21"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_21AssignVariableOpassignvariableop_21_totalIdentity_21:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_22IdentityRestoreV2:tensors:22"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_22AssignVariableOpassignvariableop_22_countIdentity_22:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_23IdentityRestoreV2:tensors:23"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_23AssignVariableOpassignvariableop_23_total_1Identity_23:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_24IdentityRestoreV2:tensors:24"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_24AssignVariableOpassignvariableop_24_count_1Identity_24:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_25IdentityRestoreV2:tensors:25"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_25AssignVariableOpassignvariableop_25_total_2Identity_25:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_26IdentityRestoreV2:tensors:26"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_26AssignVariableOpassignvariableop_26_count_2Identity_26:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_27IdentityRestoreV2:tensors:27"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_27AssignVariableOpassignvariableop_27_total_3Identity_27:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_28IdentityRestoreV2:tensors:28"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_28AssignVariableOpassignvariableop_28_count_3Identity_28:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_29IdentityRestoreV2:tensors:29"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_29AssignVariableOp$assignvariableop_29_adam_x1_kernel_mIdentity_29:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_30IdentityRestoreV2:tensors:30"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_30AssignVariableOp"assignvariableop_30_adam_x1_bias_mIdentity_30:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_31IdentityRestoreV2:tensors:31"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_31AssignVariableOp$assignvariableop_31_adam_x2_kernel_mIdentity_31:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_32IdentityRestoreV2:tensors:32"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_32AssignVariableOp"assignvariableop_32_adam_x2_bias_mIdentity_32:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_33IdentityRestoreV2:tensors:33"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_33AssignVariableOp%assignvariableop_33_adam_x3a_kernel_mIdentity_33:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_34IdentityRestoreV2:tensors:34"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_34AssignVariableOp#assignvariableop_34_adam_x3a_bias_mIdentity_34:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_35IdentityRestoreV2:tensors:35"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_35AssignVariableOp%assignvariableop_35_adam_x3b_kernel_mIdentity_35:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_36IdentityRestoreV2:tensors:36"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_36AssignVariableOp#assignvariableop_36_adam_x3b_bias_mIdentity_36:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_37IdentityRestoreV2:tensors:37"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_37AssignVariableOp%assignvariableop_37_adam_x3c_kernel_mIdentity_37:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_38IdentityRestoreV2:tensors:38"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_38AssignVariableOp#assignvariableop_38_adam_x3c_bias_mIdentity_38:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_39IdentityRestoreV2:tensors:39"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_39AssignVariableOp&assignvariableop_39_adam_hout_kernel_mIdentity_39:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_40IdentityRestoreV2:tensors:40"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_40AssignVariableOp$assignvariableop_40_adam_hout_bias_mIdentity_40:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_41IdentityRestoreV2:tensors:41"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_41AssignVariableOp&assignvariableop_41_adam_vout_kernel_mIdentity_41:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_42IdentityRestoreV2:tensors:42"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_42AssignVariableOp$assignvariableop_42_adam_vout_bias_mIdentity_42:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_43IdentityRestoreV2:tensors:43"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_43AssignVariableOp&assignvariableop_43_adam_lout_kernel_mIdentity_43:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_44IdentityRestoreV2:tensors:44"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_44AssignVariableOp$assignvariableop_44_adam_lout_bias_mIdentity_44:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_45IdentityRestoreV2:tensors:45"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_45AssignVariableOp$assignvariableop_45_adam_x1_kernel_vIdentity_45:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_46IdentityRestoreV2:tensors:46"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_46AssignVariableOp"assignvariableop_46_adam_x1_bias_vIdentity_46:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_47IdentityRestoreV2:tensors:47"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_47AssignVariableOp$assignvariableop_47_adam_x2_kernel_vIdentity_47:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_48IdentityRestoreV2:tensors:48"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_48AssignVariableOp"assignvariableop_48_adam_x2_bias_vIdentity_48:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_49IdentityRestoreV2:tensors:49"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_49AssignVariableOp%assignvariableop_49_adam_x3a_kernel_vIdentity_49:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_50IdentityRestoreV2:tensors:50"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_50AssignVariableOp#assignvariableop_50_adam_x3a_bias_vIdentity_50:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_51IdentityRestoreV2:tensors:51"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_51AssignVariableOp%assignvariableop_51_adam_x3b_kernel_vIdentity_51:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_52IdentityRestoreV2:tensors:52"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_52AssignVariableOp#assignvariableop_52_adam_x3b_bias_vIdentity_52:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_53IdentityRestoreV2:tensors:53"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_53AssignVariableOp%assignvariableop_53_adam_x3c_kernel_vIdentity_53:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_54IdentityRestoreV2:tensors:54"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_54AssignVariableOp#assignvariableop_54_adam_x3c_bias_vIdentity_54:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_55IdentityRestoreV2:tensors:55"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_55AssignVariableOp&assignvariableop_55_adam_hout_kernel_vIdentity_55:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_56IdentityRestoreV2:tensors:56"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_56AssignVariableOp$assignvariableop_56_adam_hout_bias_vIdentity_56:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_57IdentityRestoreV2:tensors:57"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_57AssignVariableOp&assignvariableop_57_adam_vout_kernel_vIdentity_57:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_58IdentityRestoreV2:tensors:58"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_58AssignVariableOp$assignvariableop_58_adam_vout_bias_vIdentity_58:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_59IdentityRestoreV2:tensors:59"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_59AssignVariableOp&assignvariableop_59_adam_lout_kernel_vIdentity_59:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_60IdentityRestoreV2:tensors:60"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_60AssignVariableOp$assignvariableop_60_adam_lout_bias_vIdentity_60:output:0"/device:CPU:0*
_output_shapes
 *
dtype01
NoOpNoOp"/device:CPU:0*
_output_shapes
 ?
Identity_61Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_29^AssignVariableOp_3^AssignVariableOp_30^AssignVariableOp_31^AssignVariableOp_32^AssignVariableOp_33^AssignVariableOp_34^AssignVariableOp_35^AssignVariableOp_36^AssignVariableOp_37^AssignVariableOp_38^AssignVariableOp_39^AssignVariableOp_4^AssignVariableOp_40^AssignVariableOp_41^AssignVariableOp_42^AssignVariableOp_43^AssignVariableOp_44^AssignVariableOp_45^AssignVariableOp_46^AssignVariableOp_47^AssignVariableOp_48^AssignVariableOp_49^AssignVariableOp_5^AssignVariableOp_50^AssignVariableOp_51^AssignVariableOp_52^AssignVariableOp_53^AssignVariableOp_54^AssignVariableOp_55^AssignVariableOp_56^AssignVariableOp_57^AssignVariableOp_58^AssignVariableOp_59^AssignVariableOp_6^AssignVariableOp_60^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: W
Identity_62IdentityIdentity_61:output:0^NoOp_1*
T0*
_output_shapes
: ?

NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_29^AssignVariableOp_3^AssignVariableOp_30^AssignVariableOp_31^AssignVariableOp_32^AssignVariableOp_33^AssignVariableOp_34^AssignVariableOp_35^AssignVariableOp_36^AssignVariableOp_37^AssignVariableOp_38^AssignVariableOp_39^AssignVariableOp_4^AssignVariableOp_40^AssignVariableOp_41^AssignVariableOp_42^AssignVariableOp_43^AssignVariableOp_44^AssignVariableOp_45^AssignVariableOp_46^AssignVariableOp_47^AssignVariableOp_48^AssignVariableOp_49^AssignVariableOp_5^AssignVariableOp_50^AssignVariableOp_51^AssignVariableOp_52^AssignVariableOp_53^AssignVariableOp_54^AssignVariableOp_55^AssignVariableOp_56^AssignVariableOp_57^AssignVariableOp_58^AssignVariableOp_59^AssignVariableOp_6^AssignVariableOp_60^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9*"
_acd_function_control_output(*
_output_shapes
 "#
identity_62Identity_62:output:0*?
_input_shapes~
|: : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12*
AssignVariableOp_10AssignVariableOp_102*
AssignVariableOp_11AssignVariableOp_112*
AssignVariableOp_12AssignVariableOp_122*
AssignVariableOp_13AssignVariableOp_132*
AssignVariableOp_14AssignVariableOp_142*
AssignVariableOp_15AssignVariableOp_152*
AssignVariableOp_16AssignVariableOp_162*
AssignVariableOp_17AssignVariableOp_172*
AssignVariableOp_18AssignVariableOp_182*
AssignVariableOp_19AssignVariableOp_192(
AssignVariableOp_2AssignVariableOp_22*
AssignVariableOp_20AssignVariableOp_202*
AssignVariableOp_21AssignVariableOp_212*
AssignVariableOp_22AssignVariableOp_222*
AssignVariableOp_23AssignVariableOp_232*
AssignVariableOp_24AssignVariableOp_242*
AssignVariableOp_25AssignVariableOp_252*
AssignVariableOp_26AssignVariableOp_262*
AssignVariableOp_27AssignVariableOp_272*
AssignVariableOp_28AssignVariableOp_282*
AssignVariableOp_29AssignVariableOp_292(
AssignVariableOp_3AssignVariableOp_32*
AssignVariableOp_30AssignVariableOp_302*
AssignVariableOp_31AssignVariableOp_312*
AssignVariableOp_32AssignVariableOp_322*
AssignVariableOp_33AssignVariableOp_332*
AssignVariableOp_34AssignVariableOp_342*
AssignVariableOp_35AssignVariableOp_352*
AssignVariableOp_36AssignVariableOp_362*
AssignVariableOp_37AssignVariableOp_372*
AssignVariableOp_38AssignVariableOp_382*
AssignVariableOp_39AssignVariableOp_392(
AssignVariableOp_4AssignVariableOp_42*
AssignVariableOp_40AssignVariableOp_402*
AssignVariableOp_41AssignVariableOp_412*
AssignVariableOp_42AssignVariableOp_422*
AssignVariableOp_43AssignVariableOp_432*
AssignVariableOp_44AssignVariableOp_442*
AssignVariableOp_45AssignVariableOp_452*
AssignVariableOp_46AssignVariableOp_462*
AssignVariableOp_47AssignVariableOp_472*
AssignVariableOp_48AssignVariableOp_482*
AssignVariableOp_49AssignVariableOp_492(
AssignVariableOp_5AssignVariableOp_52*
AssignVariableOp_50AssignVariableOp_502*
AssignVariableOp_51AssignVariableOp_512*
AssignVariableOp_52AssignVariableOp_522*
AssignVariableOp_53AssignVariableOp_532*
AssignVariableOp_54AssignVariableOp_542*
AssignVariableOp_55AssignVariableOp_552*
AssignVariableOp_56AssignVariableOp_562*
AssignVariableOp_57AssignVariableOp_572*
AssignVariableOp_58AssignVariableOp_582*
AssignVariableOp_59AssignVariableOp_592(
AssignVariableOp_6AssignVariableOp_62*
AssignVariableOp_60AssignVariableOp_602(
AssignVariableOp_7AssignVariableOp_72(
AssignVariableOp_8AssignVariableOp_82(
AssignVariableOp_9AssignVariableOp_9:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
?p
?
__inference__traced_save_174932
file_prefix(
$savev2_x1_kernel_read_readvariableop&
"savev2_x1_bias_read_readvariableop(
$savev2_x2_kernel_read_readvariableop&
"savev2_x2_bias_read_readvariableop)
%savev2_x3a_kernel_read_readvariableop'
#savev2_x3a_bias_read_readvariableop)
%savev2_x3b_kernel_read_readvariableop'
#savev2_x3b_bias_read_readvariableop)
%savev2_x3c_kernel_read_readvariableop'
#savev2_x3c_bias_read_readvariableop*
&savev2_hout_kernel_read_readvariableop(
$savev2_hout_bias_read_readvariableop*
&savev2_vout_kernel_read_readvariableop(
$savev2_vout_bias_read_readvariableop*
&savev2_lout_kernel_read_readvariableop(
$savev2_lout_bias_read_readvariableop(
$savev2_adam_iter_read_readvariableop	*
&savev2_adam_beta_1_read_readvariableop*
&savev2_adam_beta_2_read_readvariableop)
%savev2_adam_decay_read_readvariableop1
-savev2_adam_learning_rate_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop&
"savev2_total_1_read_readvariableop&
"savev2_count_1_read_readvariableop&
"savev2_total_2_read_readvariableop&
"savev2_count_2_read_readvariableop&
"savev2_total_3_read_readvariableop&
"savev2_count_3_read_readvariableop/
+savev2_adam_x1_kernel_m_read_readvariableop-
)savev2_adam_x1_bias_m_read_readvariableop/
+savev2_adam_x2_kernel_m_read_readvariableop-
)savev2_adam_x2_bias_m_read_readvariableop0
,savev2_adam_x3a_kernel_m_read_readvariableop.
*savev2_adam_x3a_bias_m_read_readvariableop0
,savev2_adam_x3b_kernel_m_read_readvariableop.
*savev2_adam_x3b_bias_m_read_readvariableop0
,savev2_adam_x3c_kernel_m_read_readvariableop.
*savev2_adam_x3c_bias_m_read_readvariableop1
-savev2_adam_hout_kernel_m_read_readvariableop/
+savev2_adam_hout_bias_m_read_readvariableop1
-savev2_adam_vout_kernel_m_read_readvariableop/
+savev2_adam_vout_bias_m_read_readvariableop1
-savev2_adam_lout_kernel_m_read_readvariableop/
+savev2_adam_lout_bias_m_read_readvariableop/
+savev2_adam_x1_kernel_v_read_readvariableop-
)savev2_adam_x1_bias_v_read_readvariableop/
+savev2_adam_x2_kernel_v_read_readvariableop-
)savev2_adam_x2_bias_v_read_readvariableop0
,savev2_adam_x3a_kernel_v_read_readvariableop.
*savev2_adam_x3a_bias_v_read_readvariableop0
,savev2_adam_x3b_kernel_v_read_readvariableop.
*savev2_adam_x3b_bias_v_read_readvariableop0
,savev2_adam_x3c_kernel_v_read_readvariableop.
*savev2_adam_x3c_bias_v_read_readvariableop1
-savev2_adam_hout_kernel_v_read_readvariableop/
+savev2_adam_hout_bias_v_read_readvariableop1
-savev2_adam_vout_kernel_v_read_readvariableop/
+savev2_adam_vout_bias_v_read_readvariableop1
-savev2_adam_lout_kernel_v_read_readvariableop/
+savev2_adam_lout_bias_v_read_readvariableop
savev2_const

identity_1??MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part?
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : ?
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: ?!
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:>*
dtype0*?!
value?!B?!>B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-3/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-3/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-5/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-5/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-6/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-6/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-7/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-7/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/2/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/2/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/3/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/3/count/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-5/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-5/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-6/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-6/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-7/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-7/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-3/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-5/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-5/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-6/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-6/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-7/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-7/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH?
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:>*
dtype0*?
value?B?>B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B ?
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0$savev2_x1_kernel_read_readvariableop"savev2_x1_bias_read_readvariableop$savev2_x2_kernel_read_readvariableop"savev2_x2_bias_read_readvariableop%savev2_x3a_kernel_read_readvariableop#savev2_x3a_bias_read_readvariableop%savev2_x3b_kernel_read_readvariableop#savev2_x3b_bias_read_readvariableop%savev2_x3c_kernel_read_readvariableop#savev2_x3c_bias_read_readvariableop&savev2_hout_kernel_read_readvariableop$savev2_hout_bias_read_readvariableop&savev2_vout_kernel_read_readvariableop$savev2_vout_bias_read_readvariableop&savev2_lout_kernel_read_readvariableop$savev2_lout_bias_read_readvariableop$savev2_adam_iter_read_readvariableop&savev2_adam_beta_1_read_readvariableop&savev2_adam_beta_2_read_readvariableop%savev2_adam_decay_read_readvariableop-savev2_adam_learning_rate_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop"savev2_total_1_read_readvariableop"savev2_count_1_read_readvariableop"savev2_total_2_read_readvariableop"savev2_count_2_read_readvariableop"savev2_total_3_read_readvariableop"savev2_count_3_read_readvariableop+savev2_adam_x1_kernel_m_read_readvariableop)savev2_adam_x1_bias_m_read_readvariableop+savev2_adam_x2_kernel_m_read_readvariableop)savev2_adam_x2_bias_m_read_readvariableop,savev2_adam_x3a_kernel_m_read_readvariableop*savev2_adam_x3a_bias_m_read_readvariableop,savev2_adam_x3b_kernel_m_read_readvariableop*savev2_adam_x3b_bias_m_read_readvariableop,savev2_adam_x3c_kernel_m_read_readvariableop*savev2_adam_x3c_bias_m_read_readvariableop-savev2_adam_hout_kernel_m_read_readvariableop+savev2_adam_hout_bias_m_read_readvariableop-savev2_adam_vout_kernel_m_read_readvariableop+savev2_adam_vout_bias_m_read_readvariableop-savev2_adam_lout_kernel_m_read_readvariableop+savev2_adam_lout_bias_m_read_readvariableop+savev2_adam_x1_kernel_v_read_readvariableop)savev2_adam_x1_bias_v_read_readvariableop+savev2_adam_x2_kernel_v_read_readvariableop)savev2_adam_x2_bias_v_read_readvariableop,savev2_adam_x3a_kernel_v_read_readvariableop*savev2_adam_x3a_bias_v_read_readvariableop,savev2_adam_x3b_kernel_v_read_readvariableop*savev2_adam_x3b_bias_v_read_readvariableop,savev2_adam_x3c_kernel_v_read_readvariableop*savev2_adam_x3c_bias_v_read_readvariableop-savev2_adam_hout_kernel_v_read_readvariableop+savev2_adam_hout_bias_v_read_readvariableop-savev2_adam_vout_kernel_v_read_readvariableop+savev2_adam_vout_bias_v_read_readvariableop-savev2_adam_lout_kernel_v_read_readvariableop+savev2_adam_lout_bias_v_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *L
dtypesB
@2>	?
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:?
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*?
_input_shapes?
?: :@:@:@@:@:@@:@:@@:@:@@:@:@::@::@:: : : : : : : : : : : : : :@:@:@@:@:@@:@:@@:@:@@:@:@::@::@::@:@:@@:@:@@:@:@@:@:@@:@:@::@::@:: 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:$ 

_output_shapes

:@: 

_output_shapes
:@:$ 

_output_shapes

:@@: 

_output_shapes
:@:$ 

_output_shapes

:@@: 

_output_shapes
:@:$ 

_output_shapes

:@@: 

_output_shapes
:@:$	 

_output_shapes

:@@: 


_output_shapes
:@:$ 

_output_shapes

:@: 

_output_shapes
::$ 

_output_shapes

:@: 

_output_shapes
::$ 

_output_shapes

:@: 

_output_shapes
::

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :$ 

_output_shapes

:@: 

_output_shapes
:@:$  

_output_shapes

:@@: !

_output_shapes
:@:$" 

_output_shapes

:@@: #

_output_shapes
:@:$$ 

_output_shapes

:@@: %

_output_shapes
:@:$& 

_output_shapes

:@@: '

_output_shapes
:@:$( 

_output_shapes

:@: )

_output_shapes
::$* 

_output_shapes

:@: +

_output_shapes
::$, 

_output_shapes

:@: -

_output_shapes
::$. 

_output_shapes

:@: /

_output_shapes
:@:$0 

_output_shapes

:@@: 1

_output_shapes
:@:$2 

_output_shapes

:@@: 3

_output_shapes
:@:$4 

_output_shapes

:@@: 5

_output_shapes
:@:$6 

_output_shapes

:@@: 7

_output_shapes
:@:$8 

_output_shapes

:@: 9

_output_shapes
::$: 

_output_shapes

:@: ;

_output_shapes
::$< 

_output_shapes

:@: =

_output_shapes
::>

_output_shapes
: 
?

?
?__inference_x3a_layer_call_and_return_conditional_losses_173877

inputs0
matmul_readvariableop_resource:@@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?	
?
@__inference_lout_layer_call_and_return_conditional_losses_173893

inputs0
matmul_readvariableop_resource:@-
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?)
?
A__inference_model_layer_call_and_return_conditional_losses_174315
xin
	x1_174272:@
	x1_174274:@
	x2_174277:@@
	x2_174279:@

x3c_174282:@@

x3c_174284:@

x3b_174287:@@

x3b_174289:@

x3a_174292:@@

x3a_174294:@
lout_174297:@
lout_174299:
vout_174302:@
vout_174304:
hout_174307:@
hout_174309:
identity

identity_1

identity_2??hout/StatefulPartitionedCall?lout/StatefulPartitionedCall?vout/StatefulPartitionedCall?x1/StatefulPartitionedCall?x2/StatefulPartitionedCall?x3a/StatefulPartitionedCall?x3b/StatefulPartitionedCall?x3c/StatefulPartitionedCall?
x1/StatefulPartitionedCallStatefulPartitionedCallxin	x1_174272	x1_174274*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x1_layer_call_and_return_conditional_losses_173809?
x2/StatefulPartitionedCallStatefulPartitionedCall#x1/StatefulPartitionedCall:output:0	x2_174277	x2_174279*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x2_layer_call_and_return_conditional_losses_173826?
x3c/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3c_174282
x3c_174284*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3c_layer_call_and_return_conditional_losses_173843?
x3b/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3b_174287
x3b_174289*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3b_layer_call_and_return_conditional_losses_173860?
x3a/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3a_174292
x3a_174294*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3a_layer_call_and_return_conditional_losses_173877?
lout/StatefulPartitionedCallStatefulPartitionedCall$x3c/StatefulPartitionedCall:output:0lout_174297lout_174299*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_lout_layer_call_and_return_conditional_losses_173893?
vout/StatefulPartitionedCallStatefulPartitionedCall$x3b/StatefulPartitionedCall:output:0vout_174302vout_174304*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_vout_layer_call_and_return_conditional_losses_173909?
hout/StatefulPartitionedCallStatefulPartitionedCall$x3a/StatefulPartitionedCall:output:0hout_174307hout_174309*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_hout_layer_call_and_return_conditional_losses_173926t
IdentityIdentity%hout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????v

Identity_1Identity%vout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????v

Identity_2Identity%lout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp^hout/StatefulPartitionedCall^lout/StatefulPartitionedCall^vout/StatefulPartitionedCall^x1/StatefulPartitionedCall^x2/StatefulPartitionedCall^x3a/StatefulPartitionedCall^x3b/StatefulPartitionedCall^x3c/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 2<
hout/StatefulPartitionedCallhout/StatefulPartitionedCall2<
lout/StatefulPartitionedCalllout/StatefulPartitionedCall2<
vout/StatefulPartitionedCallvout/StatefulPartitionedCall28
x1/StatefulPartitionedCallx1/StatefulPartitionedCall28
x2/StatefulPartitionedCallx2/StatefulPartitionedCall2:
x3a/StatefulPartitionedCallx3a/StatefulPartitionedCall2:
x3b/StatefulPartitionedCallx3b/StatefulPartitionedCall2:
x3c/StatefulPartitionedCallx3c/StatefulPartitionedCall:L H
'
_output_shapes
:?????????

_user_specified_namexin
?

?
>__inference_x2_layer_call_and_return_conditional_losses_173826

inputs0
matmul_readvariableop_resource:@@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?

?
?__inference_x3c_layer_call_and_return_conditional_losses_174666

inputs0
matmul_readvariableop_resource:@@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?
?
%__inference_hout_layer_call_fn_174675

inputs
unknown:@
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_hout_layer_call_and_return_conditional_losses_173926o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?	
?
@__inference_lout_layer_call_and_return_conditional_losses_174724

inputs0
matmul_readvariableop_resource:@-
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?

?
?__inference_x3c_layer_call_and_return_conditional_losses_173843

inputs0
matmul_readvariableop_resource:@@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?
?
$__inference_signature_wrapper_174364
xin
unknown:@
	unknown_0:@
	unknown_1:@@
	unknown_2:@
	unknown_3:@@
	unknown_4:@
	unknown_5:@@
	unknown_6:@
	unknown_7:@@
	unknown_8:@
	unknown_9:@

unknown_10:

unknown_11:@

unknown_12:

unknown_13:@

unknown_14:
identity

identity_1

identity_2??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallxinunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14*
Tin
2*
Tout
2*
_collective_manager_ids
 *M
_output_shapes;
9:?????????:?????????:?????????*2
_read_only_resource_inputs
	
*0
config_proto 

CPU

GPU2*0J 8? **
f%R#
!__inference__wrapped_model_173791o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????q

Identity_1Identity StatefulPartitionedCall:output:1^NoOp*
T0*'
_output_shapes
:?????????q

Identity_2Identity StatefulPartitionedCall:output:2^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:L H
'
_output_shapes
:?????????

_user_specified_namexin
?
?
#__inference_x1_layer_call_fn_174575

inputs
unknown:@
	unknown_0:@
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x1_layer_call_and_return_conditional_losses_173809o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????@`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?

?
?__inference_x3b_layer_call_and_return_conditional_losses_174646

inputs0
matmul_readvariableop_resource:@@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?

?
>__inference_x1_layer_call_and_return_conditional_losses_174586

inputs0
matmul_readvariableop_resource:@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
$__inference_x3a_layer_call_fn_174615

inputs
unknown:@@
	unknown_0:@
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3a_layer_call_and_return_conditional_losses_173877o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????@`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?
?
%__inference_lout_layer_call_fn_174714

inputs
unknown:@
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_lout_layer_call_and_return_conditional_losses_173893o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?)
?
A__inference_model_layer_call_and_return_conditional_losses_174269
xin
	x1_174226:@
	x1_174228:@
	x2_174231:@@
	x2_174233:@

x3c_174236:@@

x3c_174238:@

x3b_174241:@@

x3b_174243:@

x3a_174246:@@

x3a_174248:@
lout_174251:@
lout_174253:
vout_174256:@
vout_174258:
hout_174261:@
hout_174263:
identity

identity_1

identity_2??hout/StatefulPartitionedCall?lout/StatefulPartitionedCall?vout/StatefulPartitionedCall?x1/StatefulPartitionedCall?x2/StatefulPartitionedCall?x3a/StatefulPartitionedCall?x3b/StatefulPartitionedCall?x3c/StatefulPartitionedCall?
x1/StatefulPartitionedCallStatefulPartitionedCallxin	x1_174226	x1_174228*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x1_layer_call_and_return_conditional_losses_173809?
x2/StatefulPartitionedCallStatefulPartitionedCall#x1/StatefulPartitionedCall:output:0	x2_174231	x2_174233*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *G
fBR@
>__inference_x2_layer_call_and_return_conditional_losses_173826?
x3c/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3c_174236
x3c_174238*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3c_layer_call_and_return_conditional_losses_173843?
x3b/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3b_174241
x3b_174243*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3b_layer_call_and_return_conditional_losses_173860?
x3a/StatefulPartitionedCallStatefulPartitionedCall#x2/StatefulPartitionedCall:output:0
x3a_174246
x3a_174248*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3a_layer_call_and_return_conditional_losses_173877?
lout/StatefulPartitionedCallStatefulPartitionedCall$x3c/StatefulPartitionedCall:output:0lout_174251lout_174253*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_lout_layer_call_and_return_conditional_losses_173893?
vout/StatefulPartitionedCallStatefulPartitionedCall$x3b/StatefulPartitionedCall:output:0vout_174256vout_174258*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_vout_layer_call_and_return_conditional_losses_173909?
hout/StatefulPartitionedCallStatefulPartitionedCall$x3a/StatefulPartitionedCall:output:0hout_174261hout_174263*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_hout_layer_call_and_return_conditional_losses_173926t
IdentityIdentity%hout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????v

Identity_1Identity%vout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????v

Identity_2Identity%lout/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp^hout/StatefulPartitionedCall^lout/StatefulPartitionedCall^vout/StatefulPartitionedCall^x1/StatefulPartitionedCall^x2/StatefulPartitionedCall^x3a/StatefulPartitionedCall^x3b/StatefulPartitionedCall^x3c/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 2<
hout/StatefulPartitionedCallhout/StatefulPartitionedCall2<
lout/StatefulPartitionedCalllout/StatefulPartitionedCall2<
vout/StatefulPartitionedCallvout/StatefulPartitionedCall28
x1/StatefulPartitionedCallx1/StatefulPartitionedCall28
x2/StatefulPartitionedCallx2/StatefulPartitionedCall2:
x3a/StatefulPartitionedCallx3a/StatefulPartitionedCall2:
x3b/StatefulPartitionedCallx3b/StatefulPartitionedCall2:
x3c/StatefulPartitionedCallx3c/StatefulPartitionedCall:L H
'
_output_shapes
:?????????

_user_specified_namexin
??
?
A__inference_model_layer_call_and_return_conditional_losses_174506

inputs3
!x1_matmul_readvariableop_resource:@0
"x1_biasadd_readvariableop_resource:@3
!x2_matmul_readvariableop_resource:@@0
"x2_biasadd_readvariableop_resource:@4
"x3c_matmul_readvariableop_resource:@@1
#x3c_biasadd_readvariableop_resource:@4
"x3b_matmul_readvariableop_resource:@@1
#x3b_biasadd_readvariableop_resource:@4
"x3a_matmul_readvariableop_resource:@@1
#x3a_biasadd_readvariableop_resource:@5
#lout_matmul_readvariableop_resource:@2
$lout_biasadd_readvariableop_resource:5
#vout_matmul_readvariableop_resource:@2
$vout_biasadd_readvariableop_resource:5
#hout_matmul_readvariableop_resource:@2
$hout_biasadd_readvariableop_resource:
identity

identity_1

identity_2??hout/BiasAdd/ReadVariableOp?hout/MatMul/ReadVariableOp?lout/BiasAdd/ReadVariableOp?lout/MatMul/ReadVariableOp?vout/BiasAdd/ReadVariableOp?vout/MatMul/ReadVariableOp?x1/BiasAdd/ReadVariableOp?x1/MatMul/ReadVariableOp?x2/BiasAdd/ReadVariableOp?x2/MatMul/ReadVariableOp?x3a/BiasAdd/ReadVariableOp?x3a/MatMul/ReadVariableOp?x3b/BiasAdd/ReadVariableOp?x3b/MatMul/ReadVariableOp?x3c/BiasAdd/ReadVariableOp?x3c/MatMul/ReadVariableOpz
x1/MatMul/ReadVariableOpReadVariableOp!x1_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0o
	x1/MatMulMatMulinputs x1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@x
x1/BiasAdd/ReadVariableOpReadVariableOp"x1_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0

x1/BiasAddBiasAddx1/MatMul:product:0!x1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@V
x1/ReluRelux1/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@z
x2/MatMul/ReadVariableOpReadVariableOp!x2_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0~
	x2/MatMulMatMulx1/Relu:activations:0 x2/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@x
x2/BiasAdd/ReadVariableOpReadVariableOp"x2_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0

x2/BiasAddBiasAddx2/MatMul:product:0!x2/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@V
x2/ReluRelux2/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@|
x3c/MatMul/ReadVariableOpReadVariableOp"x3c_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?

x3c/MatMulMatMulx2/Relu:activations:0!x3c/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@z
x3c/BiasAdd/ReadVariableOpReadVariableOp#x3c_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
x3c/BiasAddBiasAddx3c/MatMul:product:0"x3c/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@X
x3c/ReluRelux3c/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@|
x3b/MatMul/ReadVariableOpReadVariableOp"x3b_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?

x3b/MatMulMatMulx2/Relu:activations:0!x3b/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@z
x3b/BiasAdd/ReadVariableOpReadVariableOp#x3b_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
x3b/BiasAddBiasAddx3b/MatMul:product:0"x3b/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@X
x3b/ReluRelux3b/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@|
x3a/MatMul/ReadVariableOpReadVariableOp"x3a_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?

x3a/MatMulMatMulx2/Relu:activations:0!x3a/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@z
x3a/BiasAdd/ReadVariableOpReadVariableOp#x3a_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
x3a/BiasAddBiasAddx3a/MatMul:product:0"x3a/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@X
x3a/ReluRelux3a/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@~
lout/MatMul/ReadVariableOpReadVariableOp#lout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
lout/MatMulMatMulx3c/Relu:activations:0"lout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????|
lout/BiasAdd/ReadVariableOpReadVariableOp$lout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
lout/BiasAddBiasAddlout/MatMul:product:0#lout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????~
vout/MatMul/ReadVariableOpReadVariableOp#vout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
vout/MatMulMatMulx3b/Relu:activations:0"vout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????|
vout/BiasAdd/ReadVariableOpReadVariableOp$vout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
vout/BiasAddBiasAddvout/MatMul:product:0#vout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????~
hout/MatMul/ReadVariableOpReadVariableOp#hout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
hout/MatMulMatMulx3a/Relu:activations:0"hout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????|
hout/BiasAdd/ReadVariableOpReadVariableOp$hout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
hout/BiasAddBiasAddhout/MatMul:product:0#hout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????`
hout/SigmoidSigmoidhout/BiasAdd:output:0*
T0*'
_output_shapes
:?????????_
IdentityIdentityhout/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:?????????f

Identity_1Identityvout/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????f

Identity_2Identitylout/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp^hout/BiasAdd/ReadVariableOp^hout/MatMul/ReadVariableOp^lout/BiasAdd/ReadVariableOp^lout/MatMul/ReadVariableOp^vout/BiasAdd/ReadVariableOp^vout/MatMul/ReadVariableOp^x1/BiasAdd/ReadVariableOp^x1/MatMul/ReadVariableOp^x2/BiasAdd/ReadVariableOp^x2/MatMul/ReadVariableOp^x3a/BiasAdd/ReadVariableOp^x3a/MatMul/ReadVariableOp^x3b/BiasAdd/ReadVariableOp^x3b/MatMul/ReadVariableOp^x3c/BiasAdd/ReadVariableOp^x3c/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 2:
hout/BiasAdd/ReadVariableOphout/BiasAdd/ReadVariableOp28
hout/MatMul/ReadVariableOphout/MatMul/ReadVariableOp2:
lout/BiasAdd/ReadVariableOplout/BiasAdd/ReadVariableOp28
lout/MatMul/ReadVariableOplout/MatMul/ReadVariableOp2:
vout/BiasAdd/ReadVariableOpvout/BiasAdd/ReadVariableOp28
vout/MatMul/ReadVariableOpvout/MatMul/ReadVariableOp26
x1/BiasAdd/ReadVariableOpx1/BiasAdd/ReadVariableOp24
x1/MatMul/ReadVariableOpx1/MatMul/ReadVariableOp26
x2/BiasAdd/ReadVariableOpx2/BiasAdd/ReadVariableOp24
x2/MatMul/ReadVariableOpx2/MatMul/ReadVariableOp28
x3a/BiasAdd/ReadVariableOpx3a/BiasAdd/ReadVariableOp26
x3a/MatMul/ReadVariableOpx3a/MatMul/ReadVariableOp28
x3b/BiasAdd/ReadVariableOpx3b/BiasAdd/ReadVariableOp26
x3b/MatMul/ReadVariableOpx3b/MatMul/ReadVariableOp28
x3c/BiasAdd/ReadVariableOpx3c/BiasAdd/ReadVariableOp26
x3c/MatMul/ReadVariableOpx3c/MatMul/ReadVariableOp:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
??
?
A__inference_model_layer_call_and_return_conditional_losses_174566

inputs3
!x1_matmul_readvariableop_resource:@0
"x1_biasadd_readvariableop_resource:@3
!x2_matmul_readvariableop_resource:@@0
"x2_biasadd_readvariableop_resource:@4
"x3c_matmul_readvariableop_resource:@@1
#x3c_biasadd_readvariableop_resource:@4
"x3b_matmul_readvariableop_resource:@@1
#x3b_biasadd_readvariableop_resource:@4
"x3a_matmul_readvariableop_resource:@@1
#x3a_biasadd_readvariableop_resource:@5
#lout_matmul_readvariableop_resource:@2
$lout_biasadd_readvariableop_resource:5
#vout_matmul_readvariableop_resource:@2
$vout_biasadd_readvariableop_resource:5
#hout_matmul_readvariableop_resource:@2
$hout_biasadd_readvariableop_resource:
identity

identity_1

identity_2??hout/BiasAdd/ReadVariableOp?hout/MatMul/ReadVariableOp?lout/BiasAdd/ReadVariableOp?lout/MatMul/ReadVariableOp?vout/BiasAdd/ReadVariableOp?vout/MatMul/ReadVariableOp?x1/BiasAdd/ReadVariableOp?x1/MatMul/ReadVariableOp?x2/BiasAdd/ReadVariableOp?x2/MatMul/ReadVariableOp?x3a/BiasAdd/ReadVariableOp?x3a/MatMul/ReadVariableOp?x3b/BiasAdd/ReadVariableOp?x3b/MatMul/ReadVariableOp?x3c/BiasAdd/ReadVariableOp?x3c/MatMul/ReadVariableOpz
x1/MatMul/ReadVariableOpReadVariableOp!x1_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0o
	x1/MatMulMatMulinputs x1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@x
x1/BiasAdd/ReadVariableOpReadVariableOp"x1_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0

x1/BiasAddBiasAddx1/MatMul:product:0!x1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@V
x1/ReluRelux1/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@z
x2/MatMul/ReadVariableOpReadVariableOp!x2_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0~
	x2/MatMulMatMulx1/Relu:activations:0 x2/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@x
x2/BiasAdd/ReadVariableOpReadVariableOp"x2_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0

x2/BiasAddBiasAddx2/MatMul:product:0!x2/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@V
x2/ReluRelux2/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@|
x3c/MatMul/ReadVariableOpReadVariableOp"x3c_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?

x3c/MatMulMatMulx2/Relu:activations:0!x3c/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@z
x3c/BiasAdd/ReadVariableOpReadVariableOp#x3c_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
x3c/BiasAddBiasAddx3c/MatMul:product:0"x3c/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@X
x3c/ReluRelux3c/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@|
x3b/MatMul/ReadVariableOpReadVariableOp"x3b_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?

x3b/MatMulMatMulx2/Relu:activations:0!x3b/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@z
x3b/BiasAdd/ReadVariableOpReadVariableOp#x3b_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
x3b/BiasAddBiasAddx3b/MatMul:product:0"x3b/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@X
x3b/ReluRelux3b/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@|
x3a/MatMul/ReadVariableOpReadVariableOp"x3a_matmul_readvariableop_resource*
_output_shapes

:@@*
dtype0?

x3a/MatMulMatMulx2/Relu:activations:0!x3a/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@z
x3a/BiasAdd/ReadVariableOpReadVariableOp#x3a_biasadd_readvariableop_resource*
_output_shapes
:@*
dtype0?
x3a/BiasAddBiasAddx3a/MatMul:product:0"x3a/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@X
x3a/ReluRelux3a/BiasAdd:output:0*
T0*'
_output_shapes
:?????????@~
lout/MatMul/ReadVariableOpReadVariableOp#lout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
lout/MatMulMatMulx3c/Relu:activations:0"lout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????|
lout/BiasAdd/ReadVariableOpReadVariableOp$lout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
lout/BiasAddBiasAddlout/MatMul:product:0#lout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????~
vout/MatMul/ReadVariableOpReadVariableOp#vout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
vout/MatMulMatMulx3b/Relu:activations:0"vout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????|
vout/BiasAdd/ReadVariableOpReadVariableOp$vout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
vout/BiasAddBiasAddvout/MatMul:product:0#vout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????~
hout/MatMul/ReadVariableOpReadVariableOp#hout_matmul_readvariableop_resource*
_output_shapes

:@*
dtype0?
hout/MatMulMatMulx3a/Relu:activations:0"hout/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????|
hout/BiasAdd/ReadVariableOpReadVariableOp$hout_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
hout/BiasAddBiasAddhout/MatMul:product:0#hout/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????`
hout/SigmoidSigmoidhout/BiasAdd:output:0*
T0*'
_output_shapes
:?????????_
IdentityIdentityhout/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:?????????f

Identity_1Identityvout/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????f

Identity_2Identitylout/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp^hout/BiasAdd/ReadVariableOp^hout/MatMul/ReadVariableOp^lout/BiasAdd/ReadVariableOp^lout/MatMul/ReadVariableOp^vout/BiasAdd/ReadVariableOp^vout/MatMul/ReadVariableOp^x1/BiasAdd/ReadVariableOp^x1/MatMul/ReadVariableOp^x2/BiasAdd/ReadVariableOp^x2/MatMul/ReadVariableOp^x3a/BiasAdd/ReadVariableOp^x3a/MatMul/ReadVariableOp^x3b/BiasAdd/ReadVariableOp^x3b/MatMul/ReadVariableOp^x3c/BiasAdd/ReadVariableOp^x3c/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 2:
hout/BiasAdd/ReadVariableOphout/BiasAdd/ReadVariableOp28
hout/MatMul/ReadVariableOphout/MatMul/ReadVariableOp2:
lout/BiasAdd/ReadVariableOplout/BiasAdd/ReadVariableOp28
lout/MatMul/ReadVariableOplout/MatMul/ReadVariableOp2:
vout/BiasAdd/ReadVariableOpvout/BiasAdd/ReadVariableOp28
vout/MatMul/ReadVariableOpvout/MatMul/ReadVariableOp26
x1/BiasAdd/ReadVariableOpx1/BiasAdd/ReadVariableOp24
x1/MatMul/ReadVariableOpx1/MatMul/ReadVariableOp26
x2/BiasAdd/ReadVariableOpx2/BiasAdd/ReadVariableOp24
x2/MatMul/ReadVariableOpx2/MatMul/ReadVariableOp28
x3a/BiasAdd/ReadVariableOpx3a/BiasAdd/ReadVariableOp26
x3a/MatMul/ReadVariableOpx3a/MatMul/ReadVariableOp28
x3b/BiasAdd/ReadVariableOpx3b/BiasAdd/ReadVariableOp26
x3b/MatMul/ReadVariableOpx3b/MatMul/ReadVariableOp28
x3c/BiasAdd/ReadVariableOpx3c/BiasAdd/ReadVariableOp26
x3c/MatMul/ReadVariableOpx3c/MatMul/ReadVariableOp:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs
?
?
%__inference_vout_layer_call_fn_174695

inputs
unknown:@
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *I
fDRB
@__inference_vout_layer_call_and_return_conditional_losses_173909o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?
?
$__inference_x3c_layer_call_fn_174655

inputs
unknown:@@
	unknown_0:@
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????@*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8? *H
fCRA
?__inference_x3c_layer_call_and_return_conditional_losses_173843o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????@`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?
?
&__inference_model_layer_call_fn_174223
xin
unknown:@
	unknown_0:@
	unknown_1:@@
	unknown_2:@
	unknown_3:@@
	unknown_4:@
	unknown_5:@@
	unknown_6:@
	unknown_7:@@
	unknown_8:@
	unknown_9:@

unknown_10:

unknown_11:@

unknown_12:

unknown_13:@

unknown_14:
identity

identity_1

identity_2??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallxinunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14*
Tin
2*
Tout
2*
_collective_manager_ids
 *M
_output_shapes;
9:?????????:?????????:?????????*2
_read_only_resource_inputs
	
*0
config_proto 

CPU

GPU2*0J 8? *J
fERC
A__inference_model_layer_call_and_return_conditional_losses_174143o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????q

Identity_1Identity StatefulPartitionedCall:output:1^NoOp*
T0*'
_output_shapes
:?????????q

Identity_2Identity StatefulPartitionedCall:output:2^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0"!

identity_2Identity_2:output:0*(
_construction_contextkEagerRuntime*F
_input_shapes5
3:?????????: : : : : : : : : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:L H
'
_output_shapes
:?????????

_user_specified_namexin
?

?
@__inference_hout_layer_call_and_return_conditional_losses_174686

inputs0
matmul_readvariableop_resource:@-
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????V
SigmoidSigmoidBiasAdd:output:0*
T0*'
_output_shapes
:?????????Z
IdentityIdentitySigmoid:y:0^NoOp*
T0*'
_output_shapes
:?????????w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?

?
@__inference_hout_layer_call_and_return_conditional_losses_173926

inputs0
matmul_readvariableop_resource:@-
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????V
SigmoidSigmoidBiasAdd:output:0*
T0*'
_output_shapes
:?????????Z
IdentityIdentitySigmoid:y:0^NoOp*
T0*'
_output_shapes
:?????????w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs
?

?
?__inference_x3a_layer_call_and_return_conditional_losses_174626

inputs0
matmul_readvariableop_resource:@@-
biasadd_readvariableop_resource:@
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:@@*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:@*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????@P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:?????????@a
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:?????????@w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????@: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????@
 
_user_specified_nameinputs"?L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*?
serving_default?
3
xin,
serving_default_xin:0?????????8
hout0
StatefulPartitionedCall:0?????????8
lout0
StatefulPartitionedCall:1?????????8
vout0
StatefulPartitionedCall:2?????????tensorflow/serving/predict:??
?
layer-0
layer_with_weights-0
layer-1
layer_with_weights-1
layer-2
layer_with_weights-2
layer-3
layer_with_weights-3
layer-4
layer_with_weights-4
layer-5
layer_with_weights-5
layer-6
layer_with_weights-6
layer-7
	layer_with_weights-7
	layer-8

	optimizer
loss
	variables
trainable_variables
regularization_losses
	keras_api

signatures
?__call__
+?&call_and_return_all_conditional_losses
?_default_save_signature"
_tf_keras_network
"
_tf_keras_input_layer
?

kernel
bias
	variables
trainable_variables
regularization_losses
	keras_api
?__call__
+?&call_and_return_all_conditional_losses"
_tf_keras_layer
?

kernel
bias
	variables
trainable_variables
regularization_losses
	keras_api
?__call__
+?&call_and_return_all_conditional_losses"
_tf_keras_layer
?

kernel
bias
	variables
 trainable_variables
!regularization_losses
"	keras_api
?__call__
+?&call_and_return_all_conditional_losses"
_tf_keras_layer
?

#kernel
$bias
%	variables
&trainable_variables
'regularization_losses
(	keras_api
?__call__
+?&call_and_return_all_conditional_losses"
_tf_keras_layer
?

)kernel
*bias
+	variables
,trainable_variables
-regularization_losses
.	keras_api
?__call__
+?&call_and_return_all_conditional_losses"
_tf_keras_layer
?

/kernel
0bias
1	variables
2trainable_variables
3regularization_losses
4	keras_api
?__call__
+?&call_and_return_all_conditional_losses"
_tf_keras_layer
?

5kernel
6bias
7	variables
8trainable_variables
9regularization_losses
:	keras_api
?__call__
+?&call_and_return_all_conditional_losses"
_tf_keras_layer
?

;kernel
<bias
=	variables
>trainable_variables
?regularization_losses
@	keras_api
?__call__
+?&call_and_return_all_conditional_losses"
_tf_keras_layer
?
Aiter

Bbeta_1

Cbeta_2
	Ddecay
Elearning_ratem?m?m?m?m?m?#m?$m?)m?*m?/m?0m?5m?6m?;m?<m?v?v?v?v?v?v?#v?$v?)v?*v?/v?0v?5v?6v?;v?<v?"
	optimizer
 "
trackable_dict_wrapper
?
0
1
2
3
4
5
#6
$7
)8
*9
/10
011
512
613
;14
<15"
trackable_list_wrapper
?
0
1
2
3
4
5
#6
$7
)8
*9
/10
011
512
613
;14
<15"
trackable_list_wrapper
 "
trackable_list_wrapper
?
Fnon_trainable_variables

Glayers
Hmetrics
Ilayer_regularization_losses
Jlayer_metrics
	variables
trainable_variables
regularization_losses
?__call__
?_default_save_signature
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
-
?serving_default"
signature_map
:@2	x1/kernel
:@2x1/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
Knon_trainable_variables

Llayers
Mmetrics
Nlayer_regularization_losses
Olayer_metrics
	variables
trainable_variables
regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:@@2	x2/kernel
:@2x2/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
Pnon_trainable_variables

Qlayers
Rmetrics
Slayer_regularization_losses
Tlayer_metrics
	variables
trainable_variables
regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:@@2
x3a/kernel
:@2x3a/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
Unon_trainable_variables

Vlayers
Wmetrics
Xlayer_regularization_losses
Ylayer_metrics
	variables
 trainable_variables
!regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:@@2
x3b/kernel
:@2x3b/bias
.
#0
$1"
trackable_list_wrapper
.
#0
$1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
Znon_trainable_variables

[layers
\metrics
]layer_regularization_losses
^layer_metrics
%	variables
&trainable_variables
'regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:@@2
x3c/kernel
:@2x3c/bias
.
)0
*1"
trackable_list_wrapper
.
)0
*1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
_non_trainable_variables

`layers
ametrics
blayer_regularization_losses
clayer_metrics
+	variables
,trainable_variables
-regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:@2hout/kernel
:2	hout/bias
.
/0
01"
trackable_list_wrapper
.
/0
01"
trackable_list_wrapper
 "
trackable_list_wrapper
?
dnon_trainable_variables

elayers
fmetrics
glayer_regularization_losses
hlayer_metrics
1	variables
2trainable_variables
3regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:@2vout/kernel
:2	vout/bias
.
50
61"
trackable_list_wrapper
.
50
61"
trackable_list_wrapper
 "
trackable_list_wrapper
?
inon_trainable_variables

jlayers
kmetrics
llayer_regularization_losses
mlayer_metrics
7	variables
8trainable_variables
9regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:@2lout/kernel
:2	lout/bias
.
;0
<1"
trackable_list_wrapper
.
;0
<1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
nnon_trainable_variables

olayers
pmetrics
qlayer_regularization_losses
rlayer_metrics
=	variables
>trainable_variables
?regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:	 (2	Adam/iter
: (2Adam/beta_1
: (2Adam/beta_2
: (2
Adam/decay
: (2Adam/learning_rate
 "
trackable_list_wrapper
_
0
1
2
3
4
5
6
7
	8"
trackable_list_wrapper
<
s0
t1
u2
v3"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
N
	wtotal
	xcount
y	variables
z	keras_api"
_tf_keras_metric
N
	{total
	|count
}	variables
~	keras_api"
_tf_keras_metric
Q
	total

?count
?	variables
?	keras_api"
_tf_keras_metric
R

?total

?count
?	variables
?	keras_api"
_tf_keras_metric
:  (2total
:  (2count
.
w0
x1"
trackable_list_wrapper
-
y	variables"
_generic_user_object
:  (2total
:  (2count
.
{0
|1"
trackable_list_wrapper
-
}	variables"
_generic_user_object
:  (2total
:  (2count
/
0
?1"
trackable_list_wrapper
.
?	variables"
_generic_user_object
:  (2total
:  (2count
0
?0
?1"
trackable_list_wrapper
.
?	variables"
_generic_user_object
 :@2Adam/x1/kernel/m
:@2Adam/x1/bias/m
 :@@2Adam/x2/kernel/m
:@2Adam/x2/bias/m
!:@@2Adam/x3a/kernel/m
:@2Adam/x3a/bias/m
!:@@2Adam/x3b/kernel/m
:@2Adam/x3b/bias/m
!:@@2Adam/x3c/kernel/m
:@2Adam/x3c/bias/m
": @2Adam/hout/kernel/m
:2Adam/hout/bias/m
": @2Adam/vout/kernel/m
:2Adam/vout/bias/m
": @2Adam/lout/kernel/m
:2Adam/lout/bias/m
 :@2Adam/x1/kernel/v
:@2Adam/x1/bias/v
 :@@2Adam/x2/kernel/v
:@2Adam/x2/bias/v
!:@@2Adam/x3a/kernel/v
:@2Adam/x3a/bias/v
!:@@2Adam/x3b/kernel/v
:@2Adam/x3b/bias/v
!:@@2Adam/x3c/kernel/v
:@2Adam/x3c/bias/v
": @2Adam/hout/kernel/v
:2Adam/hout/bias/v
": @2Adam/vout/kernel/v
:2Adam/vout/bias/v
": @2Adam/lout/kernel/v
:2Adam/lout/bias/v
?2?
&__inference_model_layer_call_fn_173974
&__inference_model_layer_call_fn_174405
&__inference_model_layer_call_fn_174446
&__inference_model_layer_call_fn_174223?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
A__inference_model_layer_call_and_return_conditional_losses_174506
A__inference_model_layer_call_and_return_conditional_losses_174566
A__inference_model_layer_call_and_return_conditional_losses_174269
A__inference_model_layer_call_and_return_conditional_losses_174315?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?B?
!__inference__wrapped_model_173791xin"?
???
FullArgSpec
args? 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
#__inference_x1_layer_call_fn_174575?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
>__inference_x1_layer_call_and_return_conditional_losses_174586?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
#__inference_x2_layer_call_fn_174595?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
>__inference_x2_layer_call_and_return_conditional_losses_174606?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
$__inference_x3a_layer_call_fn_174615?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
?__inference_x3a_layer_call_and_return_conditional_losses_174626?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
$__inference_x3b_layer_call_fn_174635?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
?__inference_x3b_layer_call_and_return_conditional_losses_174646?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
$__inference_x3c_layer_call_fn_174655?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
?__inference_x3c_layer_call_and_return_conditional_losses_174666?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
%__inference_hout_layer_call_fn_174675?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
@__inference_hout_layer_call_and_return_conditional_losses_174686?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
%__inference_vout_layer_call_fn_174695?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
@__inference_vout_layer_call_and_return_conditional_losses_174705?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
%__inference_lout_layer_call_fn_174714?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
@__inference_lout_layer_call_and_return_conditional_losses_174724?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
$__inference_signature_wrapper_174364xin"?
???
FullArgSpec
args? 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 ?
!__inference__wrapped_model_173791?)*#$;<56/0,?)
"?
?
xin?????????
? "{?x
&
hout?
hout?????????
&
lout?
lout?????????
&
vout?
vout??????????
@__inference_hout_layer_call_and_return_conditional_losses_174686\/0/?,
%?"
 ?
inputs?????????@
? "%?"
?
0?????????
? x
%__inference_hout_layer_call_fn_174675O/0/?,
%?"
 ?
inputs?????????@
? "???????????
@__inference_lout_layer_call_and_return_conditional_losses_174724\;</?,
%?"
 ?
inputs?????????@
? "%?"
?
0?????????
? x
%__inference_lout_layer_call_fn_174714O;</?,
%?"
 ?
inputs?????????@
? "???????????
A__inference_model_layer_call_and_return_conditional_losses_174269?)*#$;<56/04?1
*?'
?
xin?????????
p 

 
? "j?g
`?]
?
0/0?????????
?
0/1?????????
?
0/2?????????
? ?
A__inference_model_layer_call_and_return_conditional_losses_174315?)*#$;<56/04?1
*?'
?
xin?????????
p

 
? "j?g
`?]
?
0/0?????????
?
0/1?????????
?
0/2?????????
? ?
A__inference_model_layer_call_and_return_conditional_losses_174506?)*#$;<56/07?4
-?*
 ?
inputs?????????
p 

 
? "j?g
`?]
?
0/0?????????
?
0/1?????????
?
0/2?????????
? ?
A__inference_model_layer_call_and_return_conditional_losses_174566?)*#$;<56/07?4
-?*
 ?
inputs?????????
p

 
? "j?g
`?]
?
0/0?????????
?
0/1?????????
?
0/2?????????
? ?
&__inference_model_layer_call_fn_173974?)*#$;<56/04?1
*?'
?
xin?????????
p 

 
? "Z?W
?
0?????????
?
1?????????
?
2??????????
&__inference_model_layer_call_fn_174223?)*#$;<56/04?1
*?'
?
xin?????????
p

 
? "Z?W
?
0?????????
?
1?????????
?
2??????????
&__inference_model_layer_call_fn_174405?)*#$;<56/07?4
-?*
 ?
inputs?????????
p 

 
? "Z?W
?
0?????????
?
1?????????
?
2??????????
&__inference_model_layer_call_fn_174446?)*#$;<56/07?4
-?*
 ?
inputs?????????
p

 
? "Z?W
?
0?????????
?
1?????????
?
2??????????
$__inference_signature_wrapper_174364?)*#$;<56/03?0
? 
)?&
$
xin?
xin?????????"{?x
&
hout?
hout?????????
&
lout?
lout?????????
&
vout?
vout??????????
@__inference_vout_layer_call_and_return_conditional_losses_174705\56/?,
%?"
 ?
inputs?????????@
? "%?"
?
0?????????
? x
%__inference_vout_layer_call_fn_174695O56/?,
%?"
 ?
inputs?????????@
? "???????????
>__inference_x1_layer_call_and_return_conditional_losses_174586\/?,
%?"
 ?
inputs?????????
? "%?"
?
0?????????@
? v
#__inference_x1_layer_call_fn_174575O/?,
%?"
 ?
inputs?????????
? "??????????@?
>__inference_x2_layer_call_and_return_conditional_losses_174606\/?,
%?"
 ?
inputs?????????@
? "%?"
?
0?????????@
? v
#__inference_x2_layer_call_fn_174595O/?,
%?"
 ?
inputs?????????@
? "??????????@?
?__inference_x3a_layer_call_and_return_conditional_losses_174626\/?,
%?"
 ?
inputs?????????@
? "%?"
?
0?????????@
? w
$__inference_x3a_layer_call_fn_174615O/?,
%?"
 ?
inputs?????????@
? "??????????@?
?__inference_x3b_layer_call_and_return_conditional_losses_174646\#$/?,
%?"
 ?
inputs?????????@
? "%?"
?
0?????????@
? w
$__inference_x3b_layer_call_fn_174635O#$/?,
%?"
 ?
inputs?????????@
? "??????????@?
?__inference_x3c_layer_call_and_return_conditional_losses_174666\)*/?,
%?"
 ?
inputs?????????@
? "%?"
?
0?????????@
? w
$__inference_x3c_layer_call_fn_174655O)*/?,
%?"
 ?
inputs?????????@
? "??????????@