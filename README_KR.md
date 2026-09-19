# AXION Gen0-P

AXION Gen0-P는 기존 단일 Lane 실험을 4-Lane 병렬 연산 구조로 확장한
첫 번째 성능형 실리콘 프로토타입입니다.

## 주요 사양

- VCE 1개
- 4-Lane SIMD8 V-Core
- ADD, SUB, MUL 하위 8비트, AND, XOR, unsigned MAX/MIN
- Signed INT8 곱셈기 4개
- V-Core MUL과 SA-Core DOT4가 공유하는 곱셈기 뱅크
- 한 클럭에 DOT4 MAC 1회
- 20MHz 타이밍을 위한 곱셈/합산/누산 3단계 파이프라인
- Signed 32비트 누산기
- ReLU와 INT8 Saturation
- 누산기 32비트 전체 읽기
- 실제 ADD/DOT4 경로를 검사하는 자체진단
- 구현 목표 20MHz, 첫 실리콘 권장 시작 클럭 10MHz 이하
- GF180 Tiny Tapeout 1×2 타일

## 성능 목표

데이터가 내부 레지스터에 준비되어 있다면 파이프라인이 채워진 뒤
20MHz에서 이론상 `4 MAC × 20MHz = 80 MMAC/s`입니다. 단일 DOT4의
결과는 명령을 받은 뒤 3개의 상승 에지를 거쳐 누산기에 반영됩니다.
외부 8비트 인터페이스로 매번 새 벡터를 적재하는 지속 처리량은 이보다
낮습니다.

## 상태

현재 프로젝트는 RTL과 검증 환경을 구현한 Gen0-P 개발본입니다. 실제
제작 후보가 되려면 GitHub Actions에서 RTL, GDS, Precheck, Gate-Level,
DRC/LVS, 면적 및 타이밍 검증을 모두 통과해야 합니다.

자세한 명령은 `ARCHITECTURE.md`, 실물 테스트는 `HARDWARE_TEST.md`를
참조하십시오.
