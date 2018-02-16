module HeadMusic
  GOLDEN_RATIO = (1 + 5**0.5) / 2.0
  GOLDEN_RATIO_INVERSE = 1 / GOLDEN_RATIO
  PENALTY_FACTOR = GOLDEN_RATIO_INVERSE
  SMALL_PENALTY_FACTOR = GOLDEN_RATIO_INVERSE**0.5
end

require 'head_music/version'

require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/string/access'
require 'humanize'

# utilities
require 'head_music/utilities/hash_key'

# modules
require 'head_music/named_rudiment'

# rudiments
require 'head_music/accidental'
require 'head_music/bar'
require 'head_music/chord'
require 'head_music/circle'
require 'head_music/clef'
require 'head_music/composition'
require 'head_music/consonance'
require 'head_music/functional_interval'
require 'head_music/grand_staff'
require 'head_music/harmonic_interval'
require 'head_music/instrument'
require 'head_music/interval'
require 'head_music/key_signature'
require 'head_music/language'
require 'head_music/letter_name'
require 'head_music/melodic_interval'
require 'head_music/meter'
require 'head_music/motion'
require 'head_music/note'
require 'head_music/octave'
require 'head_music/pitch'
require 'head_music/pitch_class'
require 'head_music/placement'
require 'head_music/position'
require 'head_music/quality'
require 'head_music/rhythm'
require 'head_music/rhythmic_unit'
require 'head_music/rhythmic_value'
require 'head_music/scale'
require 'head_music/scale_degree'
require 'head_music/scale_type'
require 'head_music/sign'
require 'head_music/spelling'
require 'head_music/staff'
require 'head_music/voice'

# analysis
require 'head_music/style/analysis'
require 'head_music/style/annotation'
require 'head_music/style/mark'

# annotations
require 'head_music/style/annotations/always_move'
require 'head_music/style/annotations/approach_perfection_contrarily'
require 'head_music/style/annotations/at_least_eight_notes'
require 'head_music/style/annotations/avoid_crossing_voices'
require 'head_music/style/annotations/avoid_overlapping_voices'
require 'head_music/style/annotations/consonant_climax'
require 'head_music/style/annotations/consonant_downbeats'
require 'head_music/style/annotations/diatonic'
require 'head_music/style/annotations/direction_changes'
require 'head_music/style/annotations/end_on_perfect_consonance'
require 'head_music/style/annotations/end_on_tonic'
require 'head_music/style/annotations/frequent_direction_changes'
require 'head_music/style/annotations/limit_octave_leaps'
require 'head_music/style/annotations/moderate_direction_changes'
require 'head_music/style/annotations/mostly_conjunct'
require 'head_music/style/annotations/notes_same_length'
require 'head_music/style/annotations/no_rests'
require 'head_music/style/annotations/no_unisons_in_middle'
require 'head_music/style/annotations/one_to_one'
require 'head_music/style/annotations/prefer_contrary_motion'
require 'head_music/style/annotations/prefer_imperfect'
require 'head_music/style/annotations/prepare_octave_leaps'
require 'head_music/style/annotations/recover_large_leaps'
require 'head_music/style/annotations/singable_intervals'
require 'head_music/style/annotations/singable_range'
require 'head_music/style/annotations/single_large_leaps'
require 'head_music/style/annotations/start_on_perfect_consonance'
require 'head_music/style/annotations/start_on_tonic'
require 'head_music/style/annotations/step_down_to_final_note'
require 'head_music/style/annotations/step_out_of_unison'
require 'head_music/style/annotations/step_to_final_note'
require 'head_music/style/annotations/step_up_to_final_note'
require 'head_music/style/annotations/up_to_fourteen_notes'

# rulesets
require 'head_music/style/rulesets/fux_cantus_firmus'
require 'head_music/style/rulesets/modern_cantus_firmus'
require 'head_music/style/rulesets/first_species_melody'
require 'head_music/style/rulesets/first_species_harmony'
