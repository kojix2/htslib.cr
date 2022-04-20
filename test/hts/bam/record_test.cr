require "minitest/autorun"
require "../../../src/hts/bam"

class BamRecordTest < Minitest::Test
  def test_bam_path
    File.expand_path("../../fixtures/poo.sort.bam", __DIR__)
  end

  def aln1 : HTS::Bam::Record
    bam = HTS::Bam.new(test_bam_path)
    r = bam.first
    bam.close
    r
  end

  def test_tid
    assert_equal 0, aln1.tid
  end

  def test_tid_set
    a = aln1
    assert_equal 0, a.tid
    a.tid = 1
    assert_equal 1, a.tid
    a.tid = 0
    assert_equal 0, a.tid
  end

  def test_mate_tid
    assert_equal 0, aln1.mate_tid
  end

  def test_start
    assert_equal 3289, aln1.start
  end

  def test_stop
    assert_equal 3290, aln1.stop
  end

  def test_qname
    assert_equal "poo_3290_3833_2:0:0_2:0:0_119", aln1.qname
  end

  def test_mate_start
    assert_equal 3289, aln1.mate_start
  end

  def test_mate_pos
    assert_equal 3289, aln1.mate_pos
  end

  def test_chrom
    assert_equal "poo", aln1.chrom
  end

  def test_contig
    assert_equal "poo", aln1.contig
  end

  def test_mate_chrom
    assert_equal "poo", aln1.mate_chrom
  end

  def test_strand
    assert_equal "+", aln1.strand
  end

  def test_insert_size
    assert_equal 0, aln1.insert_size
  end

  def test_mapping_quality
    assert_equal 0, aln1.mapping_quality
  end

  def test_chrom
    assert_equal "poo", aln1.chrom
  end

  def test_cigar
    assert_instance_of HTS::Bam::Cigar, aln1.cigar
  end

  def test_qlen
    assert_equal 0, aln1.qlen
  end

  def test_rlen
    assert_equal 0, aln1.rlen
  end

  def test_sequence
    assert_equal "GGGGCAGCTTGTTCGAAGCGTGACCCCCAAGACGTCGTCCTGACGAGCACAAACTCCCATTGAGAGTGGC", aln1.sequence
  end

  def test_base_at
    aln = aln1
    assert_equal 'G', aln.base_at(0)
    assert_equal 'C', aln.base_at(4)
    assert_equal 'A', aln.base_at(5)
    assert_equal '.', aln.base_at(70)
    assert_equal 'C', aln.base_at(-1)
    assert_equal 'G', aln.base_at(-2)
    assert_equal 'G', aln.base_at(-70)
    assert_equal '.', aln.base_at(-71)
  end

  def test_base_qualities
    assert_equal ([17] * 70), aln1.base_qualities
  end

  def test_flag_str
    assert_equal "PAIRED,UNMAP,READ2", aln1.flag_str
  end

  def test_flag
    aln = aln1
    assert_instance_of HTS::Bam::Flag, aln.flag
    assert_equal 133, aln.flag.value
  end

  def test_tag
    aln = aln1
    assert_equal "70M", aln.tag("MC")
    assert_equal 0, aln.tag("AS")
    assert_equal 0, aln.tag("XS")
    assert_nil aln.tag("Tanuki")
  end

  def test_tag_int
    aln = aln1
    assert_equal "70M", aln.tag_string("MC")
    assert_equal 0, aln.tag_int("AS")
    assert_equal 0, aln.tag_int("XS")
    a = [] of Int64
    assert_equal [0], (a << aln.tag_int("AS"))
  end

  def test_to_s
    assert_equal "poo_3290_3833_2:0:0_2:0:0_119\t133\tpoo\t3290\t0\t*\t=\t3290\t0\tGGGGCAGCTTGTTCGAAGCGTGACCCCCAAGACGTCGTCCTGACGAGCACAAACTCCCATTGAGAGTGGC\t2222222222222222222222222222222222222222222222222222222222222222222222\tMC:Z:70M\tAS:i:0\tXS:i:0",
      aln1.to_s
  end

  def test_clone
    aln = aln1
    aln2 = aln.clone
    assert_equal aln.to_s, aln2.to_s
  end
end
