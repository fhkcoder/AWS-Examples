#create a new mavan project

'''sh
mvn archetype:generate \
-DgroupId=com.mycompany.app \
-DartifactId=my-app \
-DarchetypeArtifactId=maven-archetype-quickstart \
-DarchetypeVersion=1.5 \
-DinteractiveMode=false
'''

#create apache maven prohject for AWS
'''
mvn -B archetype:generate \
 -DarchetypeGroupId=software.amazon.awssdk \
 -DarchetypeArtifactId=archetype-lambda -Dservice=s3 -Dregion=US_EAST_2 \
 -DarchetypeVersion=2.30.23 \
 -DgroupId=com.example.myapp \
 -DartifactId=myapp
'''