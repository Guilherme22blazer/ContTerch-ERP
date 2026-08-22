@echo off
setlocal EnableExtensions
chcp 65001 >nul
title ERP Gestao Fiscal - Inteligencia Tributaria - Modo Seguro
cd /d "%~dp0"

if not exist ".env" (
  cls
  echo ===============================================================
  echo  ERP GESTAO FISCAL - CONFIGURACAO NECESSARIA
  echo ===============================================================
  echo.
  echo Este sistema agora usa um banco PostgreSQL em nuvem ^(Supabase,
  echo Neon, Railway, RDS ou outro compativel^) em vez do arquivo local.
  echo.
  echo 1. Copie o arquivo ".env.example" e renomeie a copia para ".env".
  echo 2. Abra o ".env" e preencha DATABASE_URL com a connection string
  echo    do seu banco PostgreSQL.
  echo 3. Execute este arquivo novamente.
  echo.
  pause
  exit /b 1
)

findstr /R /C:"^DATABASE_URL=." ".env" >nul 2>&1
if errorlevel 1 (
  cls
  echo ===============================================================
  echo  ERP GESTAO FISCAL - DATABASE_URL NAO PREENCHIDA
  echo ===============================================================
  echo.
  echo O arquivo ".env" existe, mas a linha DATABASE_URL esta vazia.
  echo Abra o ".env" e preencha DATABASE_URL com a connection string do
  echo seu banco PostgreSQL ^(Supabase, Neon, Railway, RDS...^).
  echo.
  pause
  exit /b 1
)

set "GESTAO_PYTHON="
where py >nul 2>&1
if not errorlevel 1 set "GESTAO_PYTHON=py -3"
if not defined GESTAO_PYTHON (
  where python >nul 2>&1
  if not errorlevel 1 set "GESTAO_PYTHON=python"
)

if not defined GESTAO_PYTHON (
  cls
  echo ===============================================================
  echo  ERP GESTAO FISCAL - PYTHON NAO ENCONTRADO
  echo ===============================================================
  echo.
  echo Instale o Python 3.10 ou mais recente em https://www.python.org/
  echo Durante a instalacao, marque a opcao "Add Python to PATH".
  echo Depois execute este arquivo novamente.
  echo.
  pause
  exit /b 1
)

%GESTAO_PYTHON% -m py_compile server.py >nul 2>&1
if errorlevel 1 (
  cls
  echo ===============================================================
  echo  ERP GESTAO FISCAL - SERVIDOR COM ERRO
  echo ===============================================================
  echo.
  %GESTAO_PYTHON% -m py_compile server.py
  echo.
  echo O servidor nao foi iniciado. Consulte a mensagem acima.
  pause
  exit /b 1
)

%GESTAO_PYTHON% -c "import cryptography" >nul 2>&1
if errorlevel 1 (
  cls
  echo ===============================================================
  echo  PREPARANDO A LEITURA DO CERTIFICADO DIGITAL A1
  echo ===============================================================
  echo.
  echo Instalando o componente oficial de criptografia. Aguarde...
  echo.
  %GESTAO_PYTHON% -m pip install --upgrade --only-binary=:all: -r requirements.txt
  if errorlevel 1 (
    echo.
    echo ===============================================================
    echo  NAO FOI POSSIVEL INSTALAR O COMPONENTE DE SEGURANCA
    echo ===============================================================
    echo.
    echo Verifique a conexao com a internet, proxy ou firewall e execute
    echo este arquivo novamente. O site nao sera aberto em uma porta vazia.
    echo.
    pause
    exit /b 1
  )
)

netstat -ano | findstr /R /C:":4173 .*LISTENING" >nul 2>&1
if not errorlevel 1 (
  echo O modo seguro ja esta em execucao. Abrindo a plataforma...
  start "" "http://127.0.0.1:4173/#sefaz-portal"
  exit /b 0
)

cls
echo ===============================================================
echo  ERP GESTAO FISCAL - MODO SEGURO ATIVO
echo ===============================================================
echo.
echo O navegador sera aberto automaticamente.
echo Mantenha esta janela aberta enquanto utilizar o certificado A1.
echo Para encerrar o servidor, pressione Ctrl+C nesta janela.
echo.
%GESTAO_PYTHON% server.py

echo.
echo O servidor foi encerrado. Se isso ocorreu sem sua solicitacao,
echo consulte a mensagem apresentada acima.
pause
endlocal
