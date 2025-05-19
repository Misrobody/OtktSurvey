@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem
@rem SPDX-License-Identifier: Apache-2.0
@rem

@if "%DEBUG%"=="" @echo off
@rem ##########################################################################
@rem
@rem  trace-analysis startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%"=="" set DIRNAME=.
@rem This is normally unused
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and TRACE_ANALYSIS_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if %ERRORLEVEL% equ 0 goto execute

echo. 1>&2
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH. 1>&2
echo. 1>&2
echo Please set the JAVA_HOME variable in your environment to match the 1>&2
echo location of your Java installation. 1>&2

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo. 1>&2
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME% 1>&2
echo. 1>&2
echo Please set the JAVA_HOME variable in your environment to match the 1>&2
echo location of your Java installation. 1>&2

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\trace-analysis-2.0.2.jar;%APP_HOME%\lib\tools-2.0.2.jar;%APP_HOME%\lib\analysis-2.0.2.jar;%APP_HOME%\lib\model-2.0.2.jar;%APP_HOME%\lib\core-2.0.2.jar;%APP_HOME%\lib\common-2.0.2.jar;%APP_HOME%\lib\logback-classic-1.5.7.jar;%APP_HOME%\lib\monitoring-2.0.2.jar;%APP_HOME%\lib\amqp-client-4.2.1.jar;%APP_HOME%\lib\teetime-3.1.1.jar;%APP_HOME%\lib\csveed-0.8.2.jar;%APP_HOME%\lib\oshi-core-6.6.5.jar;%APP_HOME%\lib\cxf-bundle-minimal-2.7.18.jar;%APP_HOME%\lib\architecture-evaluation-tool-0.0.4.jar;%APP_HOME%\lib\spoon-core-9.2.0-beta-5.jar;%APP_HOME%\lib\ehcache-core-2.5.1.jar;%APP_HOME%\lib\slf4j-api-2.0.16.jar;%APP_HOME%\lib\jcommander-1.72.jar;%APP_HOME%\lib\jackson-annotations-2.18.1.jar;%APP_HOME%\lib\jackson-core-2.18.1.jar;%APP_HOME%\lib\blueprints-core-2.6.0.jar;%APP_HOME%\lib\jackson-databind-2.18.1.jar;%APP_HOME%\lib\javax.jms-api-2.0.1.jar;%APP_HOME%\lib\javax.servlet-api-4.0.1.jar;%APP_HOME%\lib\logback-core-1.5.7.jar;%APP_HOME%\lib\org.eclipse.emf.ecore.xmi-2.38.0.jar;%APP_HOME%\lib\org.eclipse.emf.ecore-2.37.0.jar;%APP_HOME%\lib\org.eclipse.emf.common-2.31.0.jar;%APP_HOME%\lib\weka-stable-3.8.6.jar;%APP_HOME%\lib\xz-1.9.jar;%APP_HOME%\lib\commons-compress-1.27.1.jar;%APP_HOME%\lib\nanohttpd-2.3.1.jar;%APP_HOME%\lib\hppc-0.10.0.jar;%APP_HOME%\lib\snakeyaml-2.3.jar;%APP_HOME%\lib\jaxb-api-2.3.1.jar;%APP_HOME%\lib\jctools-core-4.0.5.jar;%APP_HOME%\lib\influxdb-java-2.24.jar;%APP_HOME%\lib\jersey-server-3.1.9.jar;%APP_HOME%\lib\jersey-client-3.1.9.jar;%APP_HOME%\lib\jersey-common-3.1.9.jar;%APP_HOME%\lib\jaxb-runtime-2.3.5.jar;%APP_HOME%\lib\jakarta.xml.bind-api-4.0.2.jar;%APP_HOME%\lib\javax.jws-api-1.1.jar;%APP_HOME%\lib\logging-interceptor-4.12.0.jar;%APP_HOME%\lib\converter-moshi-2.9.0.jar;%APP_HOME%\lib\retrofit-2.9.0.jar;%APP_HOME%\lib\okhttp-4.12.0.jar;%APP_HOME%\lib\java-cup-11b-20160615.jar;%APP_HOME%\lib\java-cup-runtime-11b-20160615.jar;%APP_HOME%\lib\bounce-0.18.jar;%APP_HOME%\lib\mtj-1.0.4.jar;%APP_HOME%\lib\all-1.1.2.pom;%APP_HOME%\lib\netlib-java-1.1.jar;%APP_HOME%\lib\netlib-native_ref-osx-x86_64-1.1-natives.jar;%APP_HOME%\lib\netlib-native_ref-linux-x86_64-1.1-natives.jar;%APP_HOME%\lib\netlib-native_ref-linux-i686-1.1-natives.jar;%APP_HOME%\lib\netlib-native_ref-win-x86_64-1.1-natives.jar;%APP_HOME%\lib\netlib-native_ref-win-i686-1.1-natives.jar;%APP_HOME%\lib\netlib-native_ref-linux-armhf-1.1-natives.jar;%APP_HOME%\lib\native_ref-java-1.1.jar;%APP_HOME%\lib\netlib-native_system-osx-x86_64-1.1-natives.jar;%APP_HOME%\lib\netlib-native_system-linux-x86_64-1.1-natives.jar;%APP_HOME%\lib\netlib-native_system-linux-i686-1.1-natives.jar;%APP_HOME%\lib\netlib-native_system-linux-armhf-1.1-natives.jar;%APP_HOME%\lib\netlib-native_system-win-x86_64-1.1-natives.jar;%APP_HOME%\lib\netlib-native_system-win-i686-1.1-natives.jar;%APP_HOME%\lib\native_system-java-1.1.jar;%APP_HOME%\lib\core-1.1.2.jar;%APP_HOME%\lib\arpack_combined_all-0.1.jar;%APP_HOME%\lib\jfilechooser-bookmarks-0.1.6.jar;%APP_HOME%\lib\istack-commons-runtime-3.0.12.jar;%APP_HOME%\lib\jakarta.activation-api-2.1.3.jar;%APP_HOME%\lib\flatlaf-2.0.jar;%APP_HOME%\lib\guava-33.0.0-jre.jar;%APP_HOME%\lib\commons-math3-3.6.1.jar;%APP_HOME%\lib\commons-codec-1.17.1.jar;%APP_HOME%\lib\maven-invoker-3.1.0.jar;%APP_HOME%\lib\maven-shared-utils-3.3.3.jar;%APP_HOME%\lib\commons-io-2.16.1.jar;%APP_HOME%\lib\commons-lang3-3.16.0.jar;%APP_HOME%\lib\checker-qual-3.46.0.jar;%APP_HOME%\lib\flogger-system-backend-0.6.jar;%APP_HOME%\lib\flogger-0.6.jar;%APP_HOME%\lib\javax.activation-api-1.2.0.jar;%APP_HOME%\lib\jettison-1.3.3.jar;%APP_HOME%\lib\commons-configuration-1.6.jar;%APP_HOME%\lib\spring-jms-3.0.7.RELEASE.jar;%APP_HOME%\lib\spring-tx-3.0.7.RELEASE.jar;%APP_HOME%\lib\spring-context-3.0.7.RELEASE.jar;%APP_HOME%\lib\spring-aop-3.0.7.RELEASE.jar;%APP_HOME%\lib\spring-beans-3.0.7.RELEASE.jar;%APP_HOME%\lib\spring-expression-3.0.7.RELEASE.jar;%APP_HOME%\lib\spring-core-3.0.7.RELEASE.jar;%APP_HOME%\lib\wss4j-1.6.19.jar;%APP_HOME%\lib\opensaml-2.6.1.jar;%APP_HOME%\lib\openws-1.5.1.jar;%APP_HOME%\lib\xmltooling-1.4.1.jar;%APP_HOME%\lib\xmlsec-1.5.8.jar;%APP_HOME%\lib\commons-logging-1.1.1.jar;%APP_HOME%\lib\jna-platform-5.15.0.jar;%APP_HOME%\lib\jna-5.15.0.jar;%APP_HOME%\lib\msgpack-core-0.9.6.jar;%APP_HOME%\lib\woodstox-core-asl-4.4.1.jar;%APP_HOME%\lib\stax2-api-3.1.4.jar;%APP_HOME%\lib\xmlschema-core-2.1.0.jar;%APP_HOME%\lib\geronimo-javamail_1.4_spec-1.7.1.jar;%APP_HOME%\lib\wsdl4j-1.6.3.jar;%APP_HOME%\lib\jaxb-impl-2.2.6.jar;%APP_HOME%\lib\jetty-security-8.1.15.v20140411.jar;%APP_HOME%\lib\jetty-server-8.1.15.v20140411.jar;%APP_HOME%\lib\jetty-continuation-8.1.15.v20140411.jar;%APP_HOME%\lib\jetty-http-8.1.15.v20140411.jar;%APP_HOME%\lib\jetty-io-8.1.15.v20140411.jar;%APP_HOME%\lib\jetty-util-8.1.15.v20140411.jar;%APP_HOME%\lib\geronimo-servlet_3.0_spec-1.0.jar;%APP_HOME%\lib\geronimo-jms_1.1_spec-1.1.1.jar;%APP_HOME%\lib\aopalliance-1.0.jar;%APP_HOME%\lib\spring-asm-3.0.7.RELEASE.jar;%APP_HOME%\lib\jaxb-xjc-2.2.6.jar;%APP_HOME%\lib\commons-lang-2.6.jar;%APP_HOME%\lib\msv-core-2011.1.jar;%APP_HOME%\lib\xsdlib-2010.1.jar;%APP_HOME%\lib\isorelax-20030108.jar;%APP_HOME%\lib\relaxngDatatype-20020414.jar;%APP_HOME%\lib\xml-resolver-1.2.jar;%APP_HOME%\lib\asm-3.3.1.jar;%APP_HOME%\lib\geronimo-jaxws_2.2_spec-1.1.jar;%APP_HOME%\lib\xmlbeans-2.6.0.jar;%APP_HOME%\lib\joda-time-2.2.jar;%APP_HOME%\lib\serializer-2.7.1.jar;%APP_HOME%\lib\neethi-3.0.3.jar;%APP_HOME%\lib\javax.ws.rs-api-2.0-m10.jar;%APP_HOME%\lib\jakarta.ws.rs-api-3.1.0.jar;%APP_HOME%\lib\jakarta.annotation-api-2.1.1.jar;%APP_HOME%\lib\jakarta.inject-api-2.0.1.jar;%APP_HOME%\lib\jakarta.validation-api-3.0.2.jar;%APP_HOME%\lib\osgi-resource-locator-1.0.3.jar;%APP_HOME%\lib\okio-jvm-3.6.0.jar;%APP_HOME%\lib\kotlin-stdlib-jdk8-1.9.10.jar;%APP_HOME%\lib\jclipboardhelper-0.1.0.jar;%APP_HOME%\lib\txw2-2.3.5.jar;%APP_HOME%\lib\jakarta.activation-1.2.2.jar;%APP_HOME%\lib\failureaccess-1.0.2.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\error_prone_annotations-2.23.0.jar;%APP_HOME%\lib\org.eclipse.jdt.core-3.26.0.jar;%APP_HOME%\lib\jsap-2.1.jar;%APP_HOME%\lib\maven-model-3.8.2.jar;%APP_HOME%\lib\checker-compat-qual-2.5.3.jar;%APP_HOME%\lib\stax-api-1.0.1.jar;%APP_HOME%\lib\commons-collections-3.2.1.jar;%APP_HOME%\lib\commons-digester-1.8.jar;%APP_HOME%\lib\commons-beanutils-core-1.8.0.jar;%APP_HOME%\lib\moshi-1.8.0.jar;%APP_HOME%\lib\not-yet-commons-ssl-0.3.9.jar;%APP_HOME%\lib\commons-httpclient-3.1.jar;%APP_HOME%\lib\bcprov-jdk15-1.46.jar;%APP_HOME%\lib\kotlin-stdlib-jdk7-1.9.10.jar;%APP_HOME%\lib\kotlin-stdlib-1.9.10.jar;%APP_HOME%\lib\plexus-utils-3.2.1.jar;%APP_HOME%\lib\javax.inject-1.jar;%APP_HOME%\lib\commons-beanutils-1.7.0.jar;%APP_HOME%\lib\javax.servlet-3.0.0.v201112011016.jar;%APP_HOME%\lib\kotlin-stdlib-common-1.9.10.jar;%APP_HOME%\lib\jniloader-1.1.jar;%APP_HOME%\lib\annotations-13.0.jar


@rem Execute trace-analysis
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %TRACE_ANALYSIS_OPTS%  -classpath "%CLASSPATH%" kieker.tools.trace.analysis.TraceAnalysisToolMain %*

:end
@rem End local scope for the variables with windows NT shell
if %ERRORLEVEL% equ 0 goto mainEnd

:fail
rem Set variable TRACE_ANALYSIS_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
set EXIT_CODE=%ERRORLEVEL%
if %EXIT_CODE% equ 0 set EXIT_CODE=1
if not ""=="%TRACE_ANALYSIS_EXIT_CONSOLE%" exit %EXIT_CODE%
exit /b %EXIT_CODE%

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
