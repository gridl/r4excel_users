# ��������� �������
install.packages("dplyr")

# ����������� �������
library(vroom)
library(dplyr)

# �������� ������
ga_data <- vroom("https://raw.githubusercontent.com/selesnow/publications/master/code_example/from_excel_to_r/lesson_3/ga_nowember.csv")

# ######################################################
# ���������� �����
## ���������� ������ � ����� ��������
ga_data_organic <- filter(ga_data, medium == "organic")

## ��������� �������
ga_data_organic_10 <- filter(ga_data, medium == "organic" & sessions > 10 )

## ��������� �� ���������� �������� �� ������
google_yandex <- filter(ga_data, source %in% c("google", "yandex", "bing"))

## ������ ������ ��� ����������
search_eng <- c("google", "yandex", "bing")
## ���������� ������ ��� ����������
not_searcj_eng <- filter(ga_data, ! source %in% search_eng)

# ######################################################
# ����� ��������
## ������� ����� �������� �� ���������
ga_data_�1 <- select(ga_data, date, sessions)

## ���� �� ��������
ga_data_�2 <- select(ga_data, source:sessions)

## �������� ������� �� �������� ��������� ���������� ���������
match_s  <- select_at(ga_data, vars(matches("s")))     # �������� s
match_s2 <- select_at(ga_data, vars(contains("s")))    # �������� s
last_s1  <- select_at(ga_data, vars(matches("s$")))    # ������������� �� s
last_s2  <- select_at(ga_data, vars(ends_with("s")))   # ������������� �� s
start_s1 <- select_at(ga_data, vars(matches("^s")))    # ���������� �� s
start_s2 <- select_at(ga_data, vars(starts_with("s"))) # ���������� �� s

## ������� ������ �������� �������
ga_num_column <- select_if(ga_data, is.numeric)
ga_str_column <- select_if(ga_data, is.character)

## ���������
# select - ����� �������� �� ��������
# select_at - ����� �� �������� � ������� ��� ���������� � ���������� ���������
# select_if - ����� �� ���� ����, �������� ��� ��������� ��� ��� �������� ����

# ######################################################
# ��������������� �������
new_ga_data <- rename(ga_data,
                      channel  = medium,
                      refferer = source)

# ������ ����� ��� ��������
rename_if(ga_data, is.numeric, paste0, "_n")
rename_at(ga_data, vars(matches("^s")), paste0, "_s")
rename_all(ga_data, toupper)         

# ######################################################
# ���������
## ��������� ������� (��� � Excel)
rename_all(select_if(filter(ga_data, source %in% search_eng), is.numeric), toupper)

## ���� ����� �� ����� �������� %>%
result <- ga_data %>%
            filter(source %in% search_eng) %>%
            select_if(is.numeric) %>%
            rename_all(toupper)
