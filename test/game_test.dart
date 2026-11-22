import 'package:bulmaca_motoru/bulmaca_motoru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_harita_boyama/oyun_harita_boyama.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(haritaConfig.title.length, 33);
    expect(haritaConfig.tagline.length, 33);
    for (final s in haritaConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler üretilir, doğrulanır ve kaydedilip geri yüklenir', () {
    final planner = LevelPlanner(gameId: haritaId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = haritaRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final k = haritaRules.kindForLevel(gl.spec.difficulty);
      final start = k.initial(gl.puzzle);
      expect(PState.restore(start.serialize(), gl.puzzle), isNotNull);
      expect(PLevel.fromJson(gl.puzzle.toJson()).toJson().toString(), gl.puzzle.toJson().toString());
    }
  });
}
