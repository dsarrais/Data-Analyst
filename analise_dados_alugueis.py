#!/usr/bin/env python
# coding: utf-8

# # Análise de Dados
# 

# In[5]:


# Importação de bibliotecas

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt


# In[6]:


# Leitura do arquivo csv

df = pd.read_csv('base-alugueis-sp.csv', sep= ',')
df


# In[7]:


# Tipo dados 

df.info()


# In[8]:


# Quantidade de imóveis existentes por tipo 

df.type.unique()
df.type.value_counts()


# In[9]:


# Percentual de imóveis existentes por tipo 

df.type.unique()
df.type.value_counts(normalize = True)


# In[10]:


# Média área

df.area.mean()


# In[11]:


# Valor por m2

def valor_m2(total, area):
    return (total/area)

valor_por_m2 = valor_m2(df.total, df.area).round(2)
valor_por_m2.head()


# In[12]:


# Criar coluna 'valor_por_m2'no dataframe

df['valor_por_m2'] = valor_por_m2


# In[13]:


df.head()


# In[14]:


# Média de valor por tipo de habitação

df.groupby('type')[['total']].mean().sort_values('total')


# In[15]:


# Média de valor por m2 por tipo de habitação

df.groupby('type')[['valor_por_m2']].mean().sort_values('valor_por_m2')


# In[16]:


# Filtrar os dados que correspondem a apartamento para análise do 'inf'

df.query('type == "Apartamento"')


# In[17]:


# Verificar se há valores infinitos

valores_infinitos = df[df['valor_por_m2'].isin([float('inf'), float('-inf')])]
valores_infinitos


# In[18]:


# Verificar se há valores nulos (NaN)

df[df['valor_por_m2'].isna()]


# In[19]:


# Filtrar o DataFrame para remover as linhas 'valores_infinitos' (não funcionou)

df = df[~df['valor_por_m2'].isin(valores_infinitos)]


# In[20]:


# Usar o método de indice para exclusão dos dados que possuem valor infinito

indices_para_excluir = [2983, 7085]
df = df.drop(indices_para_excluir)


# In[21]:


# Média de valor por m2 por tipo de habitação

df.groupby('type')[['valor_por_m2']].mean().sort_values('valor_por_m2')


# In[22]:


# Alterar o tipo de dados do rent e total

df[['rent', 'total']] = df[['rent', 'total']].astype(float)


# In[23]:


# Calcular o valor do aluguel por ano

df['total_ano'] = df.total * 12
df.head()


# In[24]:


df['descricao'] = df['type'] + ' em ' + df['district']
df.head()


# In[25]:


# Estatística descritiva dos dados

df.describe().round(2)


# In[26]:


# Correlação dos dados

df.corr().round(4)


# In[27]:


# Gráfico de Quantidade de Imóveis por Tipo

plt.figure(figsize=(10, 8))
ax = sns.countplot(x='type', data=df, palette='pastel')

for p in ax.patches:
    ax.annotate(f'{p.get_height()}', (p.get_x() + p.get_width() / 2., p.get_height()),
                ha='center', va='center', fontsize=12, color='black', xytext=(0, 8),
                textcoords='offset points')

ax.set_title('Quantidade de Imóveis por Tipo', fontsize=18)
ax.set_xlabel('Tipo', fontsize=12)
ax.set_ylabel('Total', fontsize=12)

plt.show()


# In[ ]:





# In[ ]:




