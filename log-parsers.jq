# Refs:
# - https://www.ietf.org/rfc/rfc3339.html#section-5.6
def internet_date_time_regex:
  "\\d{4}-\\d{2}-\\d{2}[tT]\\d{2}:\\d{2}:\\d{2}(?:\\.\\d+)?(?:[zZ]|[+-]\\d{2}:\\d{2})";

# Refs:
# - https://docs.spring.io/spring-boot/reference/features/logging.html#features.logging.log-format
# - https://docs.spring.io/spring-boot/reference/actuator/tracing.html#actuator.micrometer-tracing.logging
# - https://github.com/spring-projects/spring-boot/blob/44f5fb2a4fe9b6791b7ee0518ef5db1e07e29eb5/spring-boot-project/spring-boot/src/main/resources/org/springframework/boot/logging/logback/defaults.xml#L15
# - https://github.com/spring-projects/spring-boot/blob/44f5fb2a4fe9b6791b7ee0518ef5db1e07e29eb5/spring-boot-project/spring-boot/src/main/java/org/springframework/boot/logging/CorrelationIdFormatter.java#L71
def springboot_log_regex:
  "(?:(?<timestamp>\\d{4}-\\d{2}-\\d{2}[tT]\\d{2}:\\d{2}:\\d{2}(?:\\.\\d+)?(?:[zZ]|[+-]\\d{2}:\\d{2}))\\s+(?<severity>\\w+)\\s+(?<pid>\\d*)\\s+---(?:\\s+\\[(?<name>.*?)\\])?\\s+(?=\\[[^]]{15}\\])\\[\\s*(?<thread>.*?)\\](?:\\s+\\[(?:(?<trace>.{32})-(?<span>.{16})|.{49})\\])?\\s+(?<class>\\S*)\\s+:\\s+(?<rest>(?s).*)|(?<failed_to_parse>(?s).*))";

def parse_multiline(log_lines; regex):
  foreach(log_lines, null) as $item (
    [[], []];
    if $item == null or ($item | test(regex)) then [[$item], .[0]] else [.[0] + [$item]] end;
    if ($item == null or ($item | test(regex))) and (.[1] | length > 0) then (.[1] | join("\n")) else empty end
  );

def parse_springboot:
  capture("^" + springboot_log_regex);
