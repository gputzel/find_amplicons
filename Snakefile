configfile:"config.json"

def virtual_pcr_input(wildcards):
    org = wildcards.organism
    return {"genome":config["genomes"][org],"primers":"primers.fasta"}

rule virtual_pcr:
    input:
        unpack(virtual_pcr_input)
    output:
        amplicons="output/amplicons/{organism}.fasta",
        pcrout="output/pcrout/{organism}.txt"
    shell:
        "usearch -search_pcr {input.genome} -db {input.primers} -strand both -ampout {output.amplicons} -pcrout {output.pcrout}"

rule relabel_amplicons:
    conda:
        "envs/relabel.yml"
    input:
        "output/amplicons/{organism}.fasta"
    output:
        "output/amplicons_relabelled/{organism}.fasta"
    shell:
        'seqkit replace -p .+ -r "{wildcards.organism}_{{nr}}" {input} > {output}'

rule find_amplicons:
    input:
        ["output/amplicons_relabelled/" + organism + ".fasta" for organism in config["genomes"].keys()]
