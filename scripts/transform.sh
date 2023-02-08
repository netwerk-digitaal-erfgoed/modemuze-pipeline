#!/bin/bash
RML_PATH="./bin"
MAPPING_PATH="./mappings"
OUTPUT_PATH="./output"
SOURCES_PATH="./sources"
MAPPINGS_PATH="./mappings"
QUERY="./mappings/toSchema.rq"

for MAPPINGFILE in $MAPPINGS_PATH/*.rml 
do
  # remove space in the filename for easier processing

  echo "Processing $MAPPINGFILE..." 
  # replace a placeholder with the real name
  # of the source file to proces
  #cp $RML_MAPPING temp.rml
  #sed -i "s|?SOURCEFILE|\"${RAWFILE}\"|g" temp.rml

  # create name of the output file based on the inputfile
  FILENAME=$(basename ${MAPPINGFILE})
  FIXED_FILENAME=$MAPPING_PATH/${FILENAME/.rml/-fixed.nt}
  OUTPUTFILE=$OUTPUT_PATH/${FILENAME/rml/nt}
  OUTPUTFILE_SCHEMA=$OUTPUT_PATH/${FILENAME/.rml/-schema.ttl}
  echo "Writing raw RDF result to intermediate file..."

  # map the csv data to RDF using the RML processor
  java -jar $RML_PATH/rmlmapper.jar -m $MAPPINGFILE -o $OUTPUT_PATH/temp.nt

  # The RML processor generates triples with empty values
  # Use a simple textprocessor command to remove these
  sed -i '/\"\"./d' $OUTPUT_PATH/temp.nt
  cat $OUTPUT_PATH/temp.nt $FIXED_FILENAME > $OUTPUTFILE
  rm $OUTPUT_PATH/temp.nt
  echo "Creating schema.org version of the data..."
  sparql --data $OUTPUTFILE --query $QUERY > $OUTPUTFILE_SCHEMA

  echo "Removing intermediate output file..."
  rm $OUTPUTFILE
done



