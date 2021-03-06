"""This module was auto-generated by datajoint from an existing schema"""


import datajoint as dj

schema = dj.Schema('map_lab')





@schema
class ModifiedGene(dj.Manual):
    definition = """
    gene_modification    : varchar(60)                  
    ---
    gene_modification_description : varchar(1000)                
    """


@schema
class SkullReference(dj.Lookup):
    definition = """
    skull_reference      : varchar(60)                  
    """


@schema
class Rig(dj.Manual):
    definition = """
    rig                  : varchar(24)                  
    ---
    room                 : varchar(20)                  # example 2w.342
    rig_description      : varchar(1024)                
    """


@schema
class Person(dj.Manual):
    definition = """
    username             : varchar(24)                  
    ---
    fullname             : varchar(255)                 
    """


@schema
class AnimalSource(dj.Lookup):
    definition = """
    animal_source        : varchar(30)                  
    """


@schema
class Subject(dj.Manual):
    definition = """
    subject_id           : int                          # institution 6 digit animal ID
    ---
    -> Person
    cage_number          : int                          # institution 6 digit animal ID
    date_of_birth        : date                         # format: yyyy-mm-dd
    sex                  : enum('M','F','Unknown')      
    -> AnimalSource
    """


    class GeneModification(dj.Part):
        definition = """
        # Subject gene modifications
        -> Subject
        -> ModifiedGene
        ---
        zygosity="Unknown"   : enum('Het','Hom','Unknown')  
        type="Unknown"       : enum('Knock-in','Transgene','Unknown') 
        """


@schema
class Surgery(dj.Manual):
    definition = """
    -> Subject
    surgery_id           : int                          # surgery number
    ---
    -> Person
    start_time           : datetime                     # start time
    end_time             : datetime                     # end time
    surgery_description  : varchar(1000)                
    """


    class Procedure(dj.Part):
        definition = """
        # Other things you did to the animal
        -> Surgery
        procedure_id         : int                          
        ---
        -> SkullReference
        ml_location=null     : decimal(8,3)                 # um from ref left is positive
        ap_location=null     : decimal(8,3)                 # um from ref anterior is positive
        dv_location=null     : decimal(8,3)                 # um from dura dorsal is positive
        surgery_procedure_description : varchar(1000)                
        """


@schema
class CompleteGenotype(dj.Computed):
    definition = """
    -> Subject
    ---
    complete_genotype    : varchar(1000)                
    """


@schema
class BrainArea(dj.Lookup):
    definition = """
    brain_area="ALM"     : varchar(32)                  
    ---
    brain_area_description=null : varchar(1000)                
    """


@schema
class Hemisphere(dj.Lookup):
    definition = """
    hemisphere="left"    : varchar(32)                  
    """


@schema
class SurgeryLocation(dj.Manual):
    definition = """
    # Other things you did to the animal
    -> SurgeryProcedure
    ---
    -> Hemisphere
    -> BrainArea
    """