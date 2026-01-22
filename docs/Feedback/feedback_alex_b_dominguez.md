# Feedback Evaluación entre Pares

**Evaluador:** Martín Sánchez Novo  
**Fecha:** 19 de enero de 2025  
**Repositorio evaluado:** https://github.com/AlexBDominguez/GestionBar

---

## 1. Repositorio y README

### Aspectos positivos
- README claro y estructurado con secciones bien definidas (Descripción, Tecnologías, Características)
- Descripción funcional precisa que explica el propósito de la aplicación
- Funcionalidades documentadas en dos categorías principales: Gestión de Pedidos y Gestión de Productos

### Áreas de mejora
- El README podría incluir capturas de pantalla de la interfaz
- Falta información sobre requisitos previos (versiones de Flutter/Dart)

## 2. Comentarios y DartDoc

### Aspectos positivos
- Documentación API DartDoc generada profesionalmente en `doc/api/`
- Comentarios descriptivos con `///` en archivos clave (models, viewmodels, views)
- Descripciones claras en clases principales como `HomeViewmodel` ("ViewModel que gestiona la lógica de negocio para la vista principal")

### Áreas de mejora
- Algunos métodos privados carecen de comentarios explicativos
- La documentación podría incluir ejemplos de uso de las clases

## 3. Tooltips, Validaciones y Snackbars

### Aspectos positivos
- **Validaciones robustas** en `crear_pedido_view.dart`:
  - Valida nombre de mesa vacío con `_showAlert`
  - Valida productos seleccionados antes de guardar
  - Valida antes de ver resumen con `ScaffoldMessenger.showSnackBar`
- **Tooltips funcionales**: `tooltip: 'Nuevo pedido'` en FloatingActionButton
- **Feedback claro** con AlertDialog para errores de validación
- **SnackBars informativos** cuando faltan productos o nombre de mesa

### Comentarios adicionales
Implementación sólida de UX con manejo de errores bien estructurado

## 4. Manual de Usuario

### Aspectos positivos
- Instrucciones integradas directamente en el README
- Funcionalidades descritas de forma clara y concisa

### Comentarios adicionales
El enfoque minimalista funciona bien para esta aplicación, aunque un manual separado aportaría mayor profundidad

## 5. Guía de Despliegue

### Aspectos positivos
- Proyecto configurado con soporte multiplataforma (Android, iOS, Linux, macOS, Windows, Web)
- Estructura de archivos CMake para Linux/Windows lista para compilación
- Configuración Gradle para Android completamente funcional

---

## Conclusión

Proyecto sólido con arquitectura MVVM bien implementada, validaciones exhaustivas y documentación API profesional. El trabajo demuestra comprensión clara de Flutter y buenas prácticas de desarrollo. Las validaciones mediante AlertDialog y SnackBar aportan excelente experiencia de usuario. Una documentación de usuario/despliegue más detallada complementaría perfectamente este trabajo de alta calidad técnica.
