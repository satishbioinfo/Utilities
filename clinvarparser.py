import sys
arglist = sys.argv

### Parses Clinvar VCF file to extract informations such as AF, Phenotype , Clinical significance, variant type, snpID, variant category (missense or synonymous)
#### Download : ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/clinvar_20190821.vcf.gz #############
### step 1: Before you run this script gunzip the downloaded VCF file #######

print "Input file:"+arglist[1]+"\nOutput file:"+arglist[2]+"\n"

def parseclin (input, output ) :
    print input +"\t" +output+"\n"
    f = open(input, 'r')
    f1 = open(output, "w+")
    for x in f:
        x.rstrip('\n')
        AFE = '-'
        AFX='-'
        DN='-'
        CLNS='-'
        CLNVC='-'
        snpid='-'
        vartype='-'

        if x.startswith('#'):
            continue
        else:
            y= x.split("\t")
            head = y[0]+"\t"+y[1]+"\t"+y[3]+"\t"+y[4]+"\t"+y[2]
            a = y[-1].split(";")
            for m in a:
                if m.startswith('AF_ESP='):
                    #AF_ESP = m.replace('AF_ESP=','')
                    #print m +"\n"
                    AFE = m
                    AFE = AFE.replace('AF_ESP=','')
                elif m.startswith('AF_EXAC='):
                    AFX=m
                    AFX=AFX.replace('AF_EXAC=','')

                elif m.startswith('CLNDN='):
                    DN=m
                    DN=DN.replace('CLNDN=','')

                elif m.startswith('CLNSIG='):
                    CLNS=m
                    CLNS=CLNS.replace('CLNSIG=','')

                elif m.startswith('CLNVC='):
                    CLNVC=m
                    CLNVC=CLNVC.replace('CLNVC=','')

                elif m.startswith('RS='):
                    snpid=m
                    snpid=snpid.replace('RS=','')

                elif m.startswith('MC='):

                    b = m.split("|")
                    vartype= b[1]
                #else:
                    #AFE = 'NA'
            print head+"\t"+AFE+"\t"+AFX+"\t"+DN+"\t"+CLNS+"\t"+CLNVC+"\t"+snpid+"\t"+vartype+"\n"
            f1.write(head+"\t"+AFE+"\t"+AFX+"\t"+DN+"\t"+CLNS+"\t"+CLNVC+"\t"+snpid+"\t"+vartype+"\n")

parseclin(arglist[1],arglist[2])
