# devops

## resumo

a) Um cluster Kubernetes precisa provisionar __*nós*__ para executar processamentos, o cluster é então responsavel por gerenciar e integrar esses __*nós*__.

b) Cada nó criado pelo Cluster nada mais é do que uma VM (poder computacional) provisionado pela cloud.

c) O número total de proccessamento e memória de um cluster kubernetes é a soma de todos os poderes computacionais provisionados pela cloud.

d) O componente do cluster kubernetes responsável por enchergar um grupo de poderes computacionais como uma coisa só é o __*pool de nós*__.

e) Todos os nós do cluster precisam ter uma regra de firewall de entrada permitindo TODO o trageco da internet pois o rancher precisa fazer uma série de em portas distintas para integrar os nós e montar o cluster.

f) Cada nó comporta um determinado número de __*pods*__ e esses pods são criados aleatóriamente dentro dos nós, distribuindo a demanda computacional  entre eles.

g) Os __*pods*__ são __*containers docker (imagem)*__ que rodam dentro de um nó (poder computacional da cloud)