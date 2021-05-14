# find_amplicons

A simple Snakemake workflow for using USEARCH to find 16S amplicons in bacterial genomes.

## Usage

Put your primers in `primers.fasta` like this:

	>Forward
	GTGCCAGCMGCCGCGGTAA
	>Reverse
	GGACTACHVGGGTWTCTAAT

Edit `config.json` to indicate paths to bacterial genome FASTA files, like so:

	{
	    "genomes":{
	        "SFB":"genomes/GCF_000270205.1_ASM27020v1_genomic.fna"
	    }
	}

Then

	snakemake --cores 1 find_amplicons

should do the trick.