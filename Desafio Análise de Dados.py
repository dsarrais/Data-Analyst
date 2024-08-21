#!/usr/bin/env python
# coding: utf-8

# In[9]:


# ler o arquivo csv


# In[10]:


import pandas as pd


# In[11]:


pib = pd.read_csv("C:/PIB_tratado.csv", encoding="latin-1", sep=";")


# In[12]:


pib.head


# In[13]:


display(pib)


# In[14]:


producao = pd.read_csv("C:/producao_tratado.csv", encoding = "UTF-8", sep =";")


# In[15]:


display (producao)


# In[27]:


str regiao;
estado = producao["Estado"][1,1];
switch (estado){
    case "PIAUÍ": regiao = "Nordeste";
    case "BAHIA": regiao = "Nordeste";
    case "PERNAMBUCO": regiao = "Nordeste";
    case "RIO GRANDE DO NORTE": regiao = "Nordeste";
    case "PARAÍBA": regiao = "Nordeste";
    case "CEARÁ": regiao = "Nordeste";
    case "SERGIPE": regiao = "Nordeste";
    case "ALAGOAS": regiao = "Nordeste";
    case "MARANHÃO": regiao = "Nordeste";
    case "SÃO PAULO": regiao = "Sudeste";
    case "RIO DE JANEIRO": regiao = "Sudeste";
    case "MINAS GERAIS": regiao = "Sudeste";
    case "ESPÍRITO SANTO": regiao = "Sudeste";
    case "DISTRITO FEDERAL": regiao = "Centro-Oeste";
    case "GOIÁS": regiao = "Centro-Oeste";
    case "MATO GROSSO": regiao = "Centro-Oeste";
    case "MATO GROSSO DO SUL": regiao = "Centro-Oeste";
    case "ACRE": regiao = "Norte";
    case "AMAPÁ": regiao = "Norte";
    case "AMAZONAS": regiao = "Norte";
    case "PARÁ": regiao = "Norte";
    case "RONDÔNIA": regiao = "Norte";
    case "RORAIMA": regiao = "Norte";
    case "TOCANTINS": regiao = "Norte";
    case "PARANÁ": regiao = "Sul";
    case "SANTA CATARINA": regiao = "Sul";
    case "RIO GRANDE DO SUL": regiao = "Sul";
}


# In[31]:


regiao = pd.Series (['NORTE', 'NORDESTE','NORTE','NORTE','NORDESTE','NORDESTE','CENTRO-OESTE','SUDESTE','CENTRO-OESTE','NORDESTE','CENTRO-OESTE','CENTRO-OESTE','SUDESTE','NORTE','NORDESTE','SUL','NORDESTE','NORDESTE','SUDESTE','NORDESTE','SUL','NORTE','NORTE','SUL','SUDESTE','NORDESTE','NORTE'])


# In[32]:


display (regiao)


# In[38]:


producao_regiao = pd.concat([producao,regiao],axis=1)


# In[39]:


display (producao_regiao)


# In[44]:


producao_regiao.rename (columns = {0:"Regiao"})


# In[50]:


producao_regiao.to_csv("Dados_Regiao.csv", encoding="UTF-8")


# In[1]:





# In[ ]:




