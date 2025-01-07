@echo off

cd ..

REM ��ȡ��ǰ������ʱ�䣬��ʽΪYYYY-MM-DD_HH-MM-SS
for /f "tokens=1-4 delims=/- " %%a in ('echo %date%') do (
    set "YYYY=%%a"
    set "MM=%%b"
    set "DD=%%c"
)

for /f "tokens=1-3 delims=:." %%a in ('echo %time%') do (
    set "HH=%%a"
    set "MIN=%%b"
    set "SS=%%c"
)

REM �滻����ʱ���еĿո�Ϊ�»���
set "current_datetime=%YYYY%-%MM%-%DD%_%HH%-%MIN%-%SS%"

echo ��ȡ����...
cd .\.obsidian\
git fetch
echo *******************************

echo ͬ��Զ��..

git reset --hard origin/master
git pull
echo *******************************


cd ..
echo ������и�����...

git add .

REM �ύ���ģ���������ǰ����ʱ����û�������ύ��Ϣ
git commit -m "update config - %current_datetime%"
echo *******************************

echo ���͵�Զ�ֿ̲���...
git push

pause
