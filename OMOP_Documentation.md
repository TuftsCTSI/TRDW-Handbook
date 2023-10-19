# CTSI OMOP Data Export
## General Documentation for Researchers Receiving Exported OMOP CDM Subset

### Introduction
This document provides guidance on using a subset of Tufts electronic health record data in OMOP CDM format. If you are looking for information on how to request your own data set, review this guidance. <!-- Note for Clark:  Is there a page to data request process similar to: (https://ctsi.wakehealth.edu/service/data-and-design/data-extraction)?  I see this page: (https://www.tuftsctsi.org/research-services/informatics/) -->

### Understanding Your OMOP Data Subset
You have received a zip file containing several tables in .csv format. This data subset is derived from the Tufts CTSI <!-- Note for Clark:[insert official name]--> OMOP database which follows the conventions of OMOP 5.3 CDM. A comprehensive data dictionary is available here: [OMOP CDM v5.3](https://ohdsi.github.io). While the documentation for 5.3 applies to this subset, note that your data are a subset of the larger Tufts CTSI OMOP database and therefore the OHDSI software tool stack cannot be used on your subset.

### What you received in your data package
The data subset is provided in several CSV files. An exported data inventory typically includes:
1. OMOP.ZIP which has one CSV per OMOP table 
2. keyfile.csv: maps person_id to MRNs
3. timeline.zip: all events by person, event type, event id, and time <!-- Note for Clark: when I obtain access to the Box I will be able to describe this further.-->

### Tables 
<!-- Note for Clark:  This is a placeholder based on the code I shared with me as it is not clear if the researcher receives all files.  To be updated when I have access to Box and can take a proper inventory -->

- person.csv 
- observation_period.csv 
- visit_occurrence.csv
- visit_detail.csv 
- condition_occurrence.csv 
- drug_exposure.csv
- procedure_occurrence.csv
- device_exposure.csv
- measurement.csv 
- observation.csv
- death.csv 
- note.csv 
- note_nlp.csv 
- specimen.csv
- provider.csv 
- care_site.csv 
- location.csv 
- fact_relationship.csv 
- payer_plan_period.csv 
- cost.csv 
- drug_era.csv 
- dose_era.csv 
- condition_era.csv 
- episode.csv 
- episode_event.csv
- metadata.csv 
- cdm_source.csv
- vocabulary.csv 
- domain.csv
- concept_class.csv 
- relationship.csv 
- drug_strength.csv
- concept.csv 
- concept_synonym.csv 
- concept_relationship.csv 
- concept_ancestor.csv
- keyfile.csv 
<!-- 

### Privacy Considerations
Note for Clark:  Any policies or considerations we should alert them to regarding the use of MRNs? 

### Opening and analyzing the data
Are there any requirements about where they can open and use the files? E.g. At JHU they need to use “SAFE Desktop.”

### Hardware
<!-- Note for Clark:  Should we comment on recommended hardware/computing environment? -->

### Software
<!-- Note for Clark: Do we assume that they will not want to reassemble the files into a relational database like MS SQL, PostgreSQL, MySQL, etc? -->

<!--
### Identifiers, primary and foreign keys
[Data Model Conventions], including information on Concept vs Source (https://ohdsi.github.io/CommonDataModel/dataModelConventions.html)
Not sure if they receive PHI, source fields, but here would discuss how to look up MRNs from person_id keyfile
<!-- ## Support & Resources
For any questions or issues, please contact the CTSI informatics team at XXX Note to Clark:  Consider adding Danielle here for customer service. -->

### Additional Resources
- [The Book of OHDSI](https://ohdsi.github.io/TheBookOfOhdsi/CommonDataModel.html)
- [OMOP CDM Documentation](https://ohdsi.github.io/CommonDataModel/cdm53.html)
- [OHDSI Forums](https://forums.ohdsi.org/) for community support.
- [Athena](https://athena.ohdsi.org/) to look up individual concepts in your data

<!-- Note to Clark:  Can we make an entity relationship diagram to show how the ids in the tables are connected? -->


<!-- Note to Clark: 
I am also working on FAQs and can make some sample R code, below. I also recommend having them meet with me for an hour if helpful.  I do not mind at all.
### FAQ
- **Can I use OHDSI software?**
  No, because the tables do not represent all of the tables necessary to successfully use tools. However, you can still take advantage of the OMOP CDM structure.
  
- **What do I do if I get stuck?**
  Reach out to Danielle w/ questions.-->


### Data Limitations
Be aware of limitations or biases in the data subset. Not all EHR data are represented in this subset.

# Analysis Tools
R, SQL, Python, or any preferred data analysis software. Examples provided below are for R and SQL.
[The Book of OHDSI Chapter 9] (https://ohdsi.github.io/TheBookOfOhdsi/SqlAndR.html) provides an overview of analysis of OHDSI data in R and SQL; note that you will not be able to avail yourselves of OHDSI software tools when analyzing your exported data for the reason explained above.
<!-- Note for Clark:  Are there any limitations on software available to researchers at Tufts? -->
<!-- Note for Clark:  Assume they will not load into a database and rather read the files into R individually. I am adding SQL just in case.-->

## Data Analysis Tips 
[Hiemstra, B., Keus, F., Wetterslev, J. et al. DEBATE-statistical analysis plans for observational studies. BMC Med Res Methodol 19, 233 (2019). https://doi.org/10.1186/s12874-019-0879-5] (https://rdcu.be/doYlw)
[Data Camp Programming] "Cheat Sheets" (https://www.datacamp.com/cheat-sheet)
- Start with exploratory data analysis to understand data distributions.
- Use visualization tools to identify patterns or trends.
- Document all steps and methodologies for reproducibility.


## Analysus with SQL

The [OMOP Query Library](https://data.ohdsi.org/QueryLibrary/) is a library of commonly-used SQL queries for the OMOP Common Data Model (CDM).


## Analysis with R
Below are some sample R queries that demonstrate how to read in OMOP tables from CSV files, join them based on the `person_id` and `visit_occurrence_id` fields, and search for specific criteria.

Note: Adjust the file paths and column names accordingly based on the actual structure and location of your CSV files. The queries below are a generic representation and may need adjustments based on the specifics of your data set.

### Reading CSV files into R data frames:

```R
# Read the CSV files into R data frames
person_df <- read.csv("path_to_person_table.csv", header=TRUE, stringsAsFactors=FALSE)
visit_occurrence_df <- read.csv("path_to_visit_occurrence_table.csv", header=TRUE, stringsAsFactors=FALSE)
condition_occurrence_df <- read.csv("path_to_condition_occurrence_table.csv", header=TRUE, stringsAsFactors=FALSE)
```
Join tables based on `person_id`:

When a person has multiple visits in the `visit_occurrence` table, joining the `person` table with the `visit_occurrence` table will result in multiple rows for that person, each corresponding to a different visit. This is a standard one-to-many join operation.

```R
## Join person with visit_occurrence on 'person_id'
person_visit_df <- merge(person_df, visit_occurrence_df, by="person_id")
```

### Joining the Person-Visit table with the Condition Occurrence table:

```R
# Join the person-visit result with condition_occurrence on both 'person_id' and 'visit_occurrence_id'
full_df <- merge(person_visit_df, condition_occurrence_df, by=c("person_id", "visit_occurrence_id"))
```

### Search by a list of `person_ids`:

```R
# Define a list of person_ids to search for
search_person_ids <- c(1, 2, 3, 4, 5)

# Filter the data frame to only include rows with person_ids in the list
filtered_by_person_df <- subset(full_df, person_id %in% search_person_ids)
```

### Search by a specific condition concept code:

```R
# Define a specific condition concept code to search for
search_condition_concept_id <- 1234567

# Filter the data frame to only include rows with the specified condition concept code
filtered_by_condition_df <- subset(full_df, condition_concept_id == search_condition_concept_id)
```

### Search by a date range:

```R
# Define a date range to search for
start_date <- as.Date("2020-01-01")
end_date <- as.Date("2020-12-31")

## Filter the data frame to only include rows within the date range
filtered_by_date_df <- subset(full_df, visit_start_date >= start_date & visit_start_date <= end_date)
```
<!--TBD
## Analysis with Python 

### Required Python Libraries:

To execute the Python queries, you'll need to install the pandas library. -->
