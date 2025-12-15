# 📱 Ghid Complet - Cum să Rulezi și Verifici Laboratorul 4

## 🎯 Obiectiv Laborator
**Laborator Nr 4 (2025 - Barbaros V)**
- Încărcarea datelor de pe un web serviciu
- JSON Serialization
- Adaptare proiect existent la Clean Architecture
- Separare pe cele 3 layer-e: **Domain**, **Data**, **Presentation**

## 🌐 API Endpoints
- **Base URL**: `https://test-api-jlbn.onrender.com/v4`
- **Feed Details**: `/feed/details` - Returnează informații despre utilizator, trending news și recomandări
- **Feed**: `/feed` - Endpoint alternativ (dacă este necesar)

---

## 🚀 Pași pentru Rulare

### **Pasul 1: Instalează Dependințele**
```bash
cd /Users/mihaww/Desktop/lab4_clean_architecture
flutter pub get
```

**Ce face**: Descarcă și instalează toate pachetele necesare:
- `http` - pentru HTTP requests
- `json_annotation` și `json_serializable` - pentru JSON serialization
- `flutter_bloc` - pentru state management
- `get_it` - pentru dependency injection

**✅ Verificare**: Ar trebui să vezi `Got dependencies!` la final.

---

### **Pasul 2: Generează Codul JSON Serialization**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**Ce face**: Generează fișierele `.g.dart` necesare pentru serializarea JSON:
- `feed_data_model.g.dart`
- `news_item_model.g.dart`
- `user_model.g.dart`

**✅ Verificare**: Ar trebui să vezi `Built with build_runner` și `wrote X outputs`.

**⚠️ Notă**: Dacă modifici modelele JSON, trebuie să rulezi din nou această comandă.

---

### **Pasul 3: Verifică Codul (Opțional dar Recomandat)**
```bash
flutter analyze
```

**Ce face**: Verifică dacă există erori sau warning-uri în cod.

**✅ Verificare**: Ar trebui să fie fără erori majore.

---

### **Pasul 4: Rulează Testele**
```bash
flutter test
```

**Ce face**: Rulează testele unitare pentru a verifica:
- JSON serialization funcționează corect
- Widget-urile se construiesc corect
- Parsarea datelor de la API funcționează

**✅ Verificare**: Ar trebui să vezi `All tests passed!`

---

### **Pasul 5: Rulează Aplicația**

#### **Opțiunea A: Pe Simulator/Emulator**
```bash
flutter run
```

#### **Opțiunea B: Pe Dispositiv Fizic**
1. Conectează telefonul/tableta prin USB
2. Activează "Developer Mode" și "USB Debugging"
3. Rulează:
```bash
flutter devices  # Vezi device-urile disponibile
flutter run -d <device-id>
```

#### **Opțiunea C: Pe Web (dacă este configurat)**
```bash
flutter run -d chrome
```

**✅ Verificare**: Aplicația ar trebui să pornească și să afișeze:
- Un loading indicator la început
- User profile cu nume și număr de notificări
- Secțiunea "Trending News" cu știri
- Secțiunea "Recommendations" cu recomandări

---

## 🔍 Cum să Verifici că Totul Funcționează

### **1. Verificare Structură Clean Architecture**

#### **Domain Layer** (Entități și Interfețe)
```bash
ls -la lib/domain/entities/
ls -la lib/domain/repositories/
```

**Ar trebui să vezi**:
- ✅ `user.dart` - Entitate User
- ✅ `news_item.dart` - Entitate NewsItem
- ✅ `feed_data.dart` - Entitate FeedData
- ✅ `feed_repository.dart` - Interface Repository

#### **Data Layer** (Modele și Implementări)
```bash
ls -la lib/data/models/
ls -la lib/data/datasources/
ls -la lib/data/repositories/
```

**Ar trebui să vezi**:
- ✅ `user_model.dart` + `user_model.g.dart`
- ✅ `news_item_model.dart` + `news_item_model.g.dart`
- ✅ `feed_data_model.dart` + `feed_data_model.g.dart`
- ✅ `remote_data_source.dart` - HTTP client
- ✅ `feed_repository_impl.dart` - Implementare repository

#### **Presentation Layer** (UI și State Management)
```bash
ls -la lib/presentation/bloc/
ls -la lib/presentation/pages/
ls -la lib/presentation/widgets/
```

**Ar trebui să vezi**:
- ✅ `feed_bloc.dart`, `feed_event.dart`, `feed_state.dart`
- ✅ `feed_page.dart` - Pagina principală
- ✅ `user_profile_widget.dart`, `news_item_widget.dart`

---

### **2. Verificare Funcționalitate în Aplicație**

#### **✅ Test 1: Loading State**
- La pornirea aplicației, ar trebui să vezi un **CircularProgressIndicator**
- Acest lucru confirmă că BLoC-ul trimite evenimentul `LoadFeedEvent`

#### **✅ Test 2: Data Loading**
- După câteva secunde, datele ar trebui să se încarce
- Verifică că vezi:
  - **User Profile**: Nume (ex: "Tyler"), imagine de profil, număr notificări
  - **Trending News**: Cel puțin 2 știri cu imagini, titluri, categorii
  - **Recommendations**: Cel puțin 2 recomandări cu badge-uri de verificare

#### **✅ Test 3: Pull-to-Refresh**
- Trage în jos pe ecran pentru a reîncărca datele
- Ar trebui să vezi un loading indicator și apoi datele actualizate

#### **✅ Test 4: Error Handling**
- Dacă API-ul nu răspunde, ar trebui să vezi:
  - Un mesaj de eroare
  - Un buton "Retry" pentru a reîncerca

---

### **3. Verificare Network Requests**

#### **Verifică în Cod**
Deschide `lib/data/datasources/remote_data_source.dart`:
- ✅ Base URL este: `https://test-api-jlbn.onrender.com/v4`
- ✅ Endpoint-ul este: `/feed/details`
- ✅ Headers includ: `Content-Type: application/json`

#### **Testează API-ul Direct**
```bash
curl https://test-api-jlbn.onrender.com/v4/feed/details
```

Ar trebui să returneze JSON cu structura din `feed.json`.

---

### **4. Verificare JSON Serialization**

#### **Verifică Fișierele Generate**
```bash
ls -la lib/data/models/*.g.dart
```

Ar trebui să existe:
- ✅ `feed_data_model.g.dart`
- ✅ `news_item_model.g.dart`
- ✅ `user_model.g.dart`

#### **Verifică în Cod**
Deschide `lib/data/models/feed_data_model.dart`:
- ✅ Are `@JsonSerializable()` annotation
- ✅ Are `fromJson()` factory method
- ✅ Are `toJson()` method
- ✅ Folosește `@JsonKey()` pentru maparea câmpurilor (ex: `trending_news`)

---

### **5. Verificare Dependency Injection**

Deschide `lib/core/injection_container.dart`:
- ✅ `http.Client` este înregistrat
- ✅ `RemoteDataSource` este înregistrat
- ✅ `FeedRepository` este înregistrat
- ✅ `FeedBloc` este înregistrat ca Factory

---

## 🐛 Rezolvare Probleme Comune

### **Problema 1: "Build runner failed"**
**Soluție**:
```bash
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### **Problema 2: "No devices found"**
**Soluție**:
```bash
flutter doctor  # Verifică configurarea Flutter
flutter devices  # Vezi device-urile disponibile
```

### **Problema 3: "Failed to load feed data"**
**Soluție**:
- Verifică conexiunea la internet
- Testează API-ul direct: `curl https://test-api-jlbn.onrender.com/v4/feed/details`
- Verifică că endpoint-ul este corect în `remote_data_source.dart`

### **Problema 4: "Missing .g.dart files"**
**Soluție**:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### **Problema 5: "Dependencies not found"**
**Soluție**:
```bash
flutter pub get
flutter pub upgrade
```

---

## 📊 Checklist Final de Verificare

### **Structură Clean Architecture**
- [ ] Domain Layer: Entities și Repository interfaces există
- [ ] Data Layer: Models cu JSON serialization există
- [ ] Presentation Layer: BLoC, Pages și Widgets există
- [ ] Core: Dependency Injection configurată

### **Funcționalitate**
- [ ] Aplicația pornește fără erori
- [ ] Datele se încarcă de la API
- [ ] JSON-ul este parsat corect
- [ ] UI-ul afișează datele corect
- [ ] Pull-to-refresh funcționează
- [ ] Error handling funcționează

### **Teste**
- [ ] `flutter test` - Toate testele trec
- [ ] `flutter analyze` - Fără erori majore

### **Documentație**
- [ ] README.md există și este complet
- [ ] Codul este comentat unde este necesar

---

## 🎓 Ce Ai Învățat

1. **Clean Architecture**: Separarea codului în 3 layer-e independente
2. **JSON Serialization**: Folosirea `json_annotation` și `json_serializable`
3. **HTTP Requests**: Integrarea cu API-uri externe folosind `http` package
4. **State Management**: Folosirea BLoC pattern pentru gestionarea stării
5. **Dependency Injection**: Configurarea GetIt pentru injectarea dependențelor
6. **Error Handling**: Gestionarea erorilor în aplicație

---

## 📝 Comenzi Rapide - Cheat Sheet

```bash
# Instalează dependințele
flutter pub get

# Generează cod JSON
flutter packages pub run build_runner build --delete-conflicting-outputs

# Rulează testele
flutter test

# Verifică codul
flutter analyze

# Rulează aplicația
flutter run

# Curăță build-ul
flutter clean

# Verifică configurarea
flutter doctor
```

---

## ✅ Status Final

După ce ai urmat toți pașii și verificările:
- ✅ **Clean Architecture** implementată corect
- ✅ **JSON Serialization** funcționează
- ✅ **Web Service Integration** completă
- ✅ **State Management** cu BLoC funcțional
- ✅ **Dependency Injection** configurată
- ✅ **Teste** trec cu succes
- ✅ **UI** responsive și funcțională

**🎉 LABORATOR COMPLET IMPLEMENTAT ȘI VERIFICAT! 🎉**

---

## 📞 Suport

Dacă întâmpini probleme:
1. Verifică că ai urmat toți pașii în ordine
2. Verifică că toate dependințele sunt instalate
3. Verifică că API-ul este accesibil
4. Verifică log-urile pentru erori detaliate
5. Consultă documentația Flutter: https://flutter.dev/docs
