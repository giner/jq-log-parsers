# jq-log-parsers

# Installation

```
git clone https://github.com/giner/jq-log-parsers
cd jq-log-parsers
mkdir -p ~/.jq
cp -i log-parsers.jq ~/.jq/
```

# Usage

Merge multiple lines prefixed with internet date/time timestamp into a single line
```
cat log-samples/spring-boot.log |
  jq -Rn 'include "log-parsers"; parse_multiline(inputs; "^" + internet_date_time_regex + "\\s+")'
```

Parse as Spring Boot log
```
cat log-samples/spring-boot.log |
  jq -R 'include "log-parsers"; parse_springboot'
```

Merge multiple lines prefixed with internet date/time timestamp and then parse as Spring Boot log
```
cat log-samples/spring-boot.log |
  jq -Rn 'include "log-parsers"; parse_multiline(inputs; "^" + internet_date_time_regex + "\\s+") | parse_springboot'
```
```
# Sample output:
...
{
  "timestamp": "2025-01-11T18:43:30.649+09:00",
  "severity": "INFO",
  "pid": "1586206",
  "name": "spring-micrometer-tracing-demo",
  "thread": "nio-8080-exec-1",
  "trace": "67823d423bb7d2e7b26bbded45d4a8da",
  "span": "b26bbded45d4a8da",
  "class": "com.kishorek.Main",
  "rest": "This is my house, I have to defend it.\ntest1\n test2\ntest 3\ntest4",
  "failed_to_parse": null
}
```
