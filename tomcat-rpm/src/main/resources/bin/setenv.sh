#source all environment customization to the env.d directory 
for file in $CATALINA_BASE/env.d/*; do 

    source $file; 

done