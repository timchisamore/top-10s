This R Project is similar to work being done at Niagara Region Public Health (NRPH), who themselves found the idea
externally. The goal is to take Emergency Department (ED) visits data, hospitalization data, and death data
and combine it with population data to look at what the major causes of morbidity and mortality are in the area.
Specifically, we aggregate the linelist data by year, sex, and age group and construct rate per 100,000s. This
can inform future work by highlighting priority populations or lead to further examinations of high
occurrence diseases.

We chose to remove R00-R99 and Z00-Z99 from the ED visits data and hospitalizations data as they represent symptoms, signs, and abnormal clinical and laboratory findings, not elsewhere classified and factors influencing health status and contact with health services, respectively. These are not issues that public health actions can overtly address or influence. Additionally, we chose to remove codes 88 and 99 from the deaths data as they represent residual and symptoms, signs, ill defined, respectively. Again, these aren't actionable categories in our opinion. Further, we only include causes with a count of 5 or more in any combination of year, sex, and age group as otherwise, the rates will be unstable.