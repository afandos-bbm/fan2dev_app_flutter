import 'package:fan2dev/features/projects/domain/domain.dart';
import 'package:fan2dev/utils/result.dart';

List<ProjectsProjectTechnology> _technologies = [
  const ProjectsProjectTechnology(
    id: 0,
    name: 'Dart',
    type: ProjectsProjectTechnologyType.language,
    objective: ProjectsProjectTechnologyObjective.backend,
    logoAssetUrl: 'assets/icons/technologies/dart.svg',
    url: 'https://dart.dev/',
  ),
  const ProjectsProjectTechnology(
    id: 1,
    name: 'Flutter',
    type: ProjectsProjectTechnologyType.framework,
    objective: ProjectsProjectTechnologyObjective.mobile,
    logoAssetUrl: 'assets/icons/technologies/flutter.svg',
    url: 'https://flutter.dev/',
  ),
  const ProjectsProjectTechnology(
    id: 2,
    name: 'Firebase',
    type: ProjectsProjectTechnologyType.database,
    objective: ProjectsProjectTechnologyObjective.backend,
    logoAssetUrl: 'assets/icons/technologies/firebase.svg',
    url: 'https://firebase.google.com/',
  ),
  const ProjectsProjectTechnology(
    id: 3,
    name: 'Git',
    type: ProjectsProjectTechnologyType.tool,
    objective: ProjectsProjectTechnologyObjective.frontend,
    logoAssetUrl: 'assets/icons/technologies/git.svg',
    url: 'https://git-scm.com/',
  ),
  const ProjectsProjectTechnology(
    id: 4,
    name: 'Github',
    type: ProjectsProjectTechnologyType.tool,
    objective: ProjectsProjectTechnologyObjective.frontend,
    logoAssetUrl: 'assets/icons/technologies/github.svg',
    url: 'https://github.com/',
  ),
  const ProjectsProjectTechnology(
    id: 5,
    name: 'Express.js',
    type: ProjectsProjectTechnologyType.framework,
    objective: ProjectsProjectTechnologyObjective.backend,
    logoAssetUrl: 'assets/icons/technologies/expressjs.svg',
    url: 'https://expressjs.com/',
  ),
  const ProjectsProjectTechnology(
    id: 6,
    name: 'Node.js',
    type: ProjectsProjectTechnologyType.framework,
    objective: ProjectsProjectTechnologyObjective.backend,
    logoAssetUrl: 'assets/icons/technologies/nodejs.svg',
    url: 'https://nodejs.org/',
  ),
  const ProjectsProjectTechnology(
    id: 7,
    name: 'Typescript',
    type: ProjectsProjectTechnologyType.language,
    objective: ProjectsProjectTechnologyObjective.backend,
    logoAssetUrl: 'assets/icons/technologies/typescript.svg',
    url: 'https://www.typescriptlang.org/',
  ),
  const ProjectsProjectTechnology(
    id: 8,
    name: 'MariaDB',
    type: ProjectsProjectTechnologyType.database,
    objective: ProjectsProjectTechnologyObjective.backend,
    logoAssetUrl: 'assets/icons/technologies/mariadb.svg',
    url: 'https://mariadb.org/',
  ),
];

List<ProjectsProject> _projectList = [
  ProjectsProject(
    id: 0,
    name: 'Entropia ERP',
    logoAssetUrl: 'assets/images/projects/entropia_erp/entropia_erp_logo.png',
    description:
        'Entropia ERP es un erp para la gestión de empresas principalmente en el transporte de mercancías.',
    longDescription:
        'Entropia ERP es un erp para la gestión de empresas principalmente en el transporte de mercancías. Entropia ERP se centra en el registro de rutas tanto estándar como de contenedores, gastos, presupuestos y facturas. Se considera un ERP SaaS en el que permite tener un login desde un único sitio web para todas las empresas que se deseen gestionar. También permite registrar los datos de todas las empresas tanto clientes como proveedores, también permite registrar sus cuentas, direcciones y contactos. Por ultimo cabe destacar que tiene un panel de administración para gestionar los usuarios y permisos de acceso. Este proyecto lo desarrolle para una pequeña empresa de software de mi ciudad. Me encargue de todo en esta proyecto tanto el diseño como el desarrollo del fronted y backend. La base de datos fue diseñada junto a mi jefe con su amplia experiencia en el sector.',
    technologies: [
      _technologies[0],
      _technologies[1],
      _technologies[3],
      _technologies[4],
      _technologies[5],
      _technologies[6],
      _technologies[7],
      _technologies[8],
    ],
    status: ProjectsProjectStatus.finished,
    estimatedTimeExpended: '1yr',
    screenShotAssetUrls: const [
      'assets/images/projects/entropia_erp/entropia_erp_screenshot_1.png',
      'assets/images/projects/entropia_erp/entropia_erp_screenshot_2.png',
      'assets/images/projects/entropia_erp/entropia_erp_screenshot_3.png',
    ],
    websiteUrl: 'https://entropiasoft.net/',
  ),
  ProjectsProject(
    id: 1,
    name: 'WeCancerSurvivors',
    logoAssetUrl:
        'assets/images/projects/we_cancer_survivors/we_cancer_survivors_logo.png',
    description:
        'WeCancerSurvivors es una aplicación móvil para la gestión de pacientes con cáncer.',
    longDescription:
        'WeCancerSurvivors es una aplicación móvil para la gestión de pacientes con cáncer. Contiene 4 apartados principales: 1. Resources: Contiene información sobre el cáncer, sus tratamientos y consejos para los pacientes. 2. Community: Es un foro donde los pacientes pueden compartir sus experiencias y dudas. 3. Health: Es el apartado mas importante ya que permite a los pacientes llevar un control de su salud, registrar sus citas médicas, tratamientos, medicamentos, síntomas... 4. TeleHealth: Es un apartado donde los pacientes pueden tener una video llamada con su médico. Este proyecto lo desarrollo para la European Cancer Organization en un gran y amplio equipo agile en Bilbomatica, una empresa del Grupo Altia. En este caso forme parte del equipo de Frontend desarrollando muchas de las features asi como el sistema de autenticación, la integración con la API de la aplicación y otros servicios vitales para la aplicación.',
    technologies: [
      _technologies[0],
      _technologies[1],
      _technologies[3],
      _technologies[4],
    ],
    status: ProjectsProjectStatus.development,
    estimatedTimeExpended: '1yr',
    screenShotAssetUrls: const [
      'assets/images/projects/we_cancer_survivors/we_cancer_survivors_screenshot_1.png',
      'assets/images/projects/we_cancer_survivors/we_cancer_survivors_screenshot_2.png',
      'assets/images/projects/we_cancer_survivors/we_cancer_survivors_screenshot_3.png',
      'assets/images/projects/we_cancer_survivors/we_cancer_survivors_screenshot_4.png',
      'assets/images/projects/we_cancer_survivors/we_cancer_survivors_screenshot_5.png',
    ],
    websiteUrl: 'https://www.europeancancer.org/eu-projects/impact/smartcare',
  ),
  ProjectsProject(
    id: 2,
    name: 'Dream Diary',
    logoAssetUrl: 'assets/images/projects/dream_diary/dream_diary_logo.png',
    description:
        'Dream Diary es una aplicación de gestión de sueños que te permite registrar tus sueños y analizarlos.',
    longDescription:
        'La idea de Dream Diary es que puedas registrar tus sueños y analizarlos. Dream Diary es una aplicación de gestión de sueños que te permite registrar tus sueños, analizarlos y ver estadísticas sobre ellos. Dream Diary esta en desarrollo y espero poder lanzarla pronto. Dream Diary esta desarrollada en Flutter y Firebase y es un proyecto personal que estoy desarrollando en mi tiempo libre.',
    status: ProjectsProjectStatus.development,
    estimatedTimeExpended: '3mo',
    technologies: [
      _technologies[0],
      _technologies[1],
      _technologies[2],
      _technologies[3],
      _technologies[4],
    ],
    screenShotAssetUrls: const [
      'assets/images/projects/dream_diary/dream_diary_screenshot_1.png',
    ],
    websiteUrl: 'https://thedreamdiary.app/',
  ),
  ProjectsProject(
    id: 3,
    name: 'TaskBag',
    logoAssetUrl: 'assets/images/app_logo.png',
    description:
        'TaskBag es una increíble aplicación de gestión de tareas que te permite organizar tu vida de manera eficiente.',
    longDescription:
        'La idea de TaskBag es que puedas organizar tu vida de manera eficiente. TaskBag es una aplicación de gestión de tareas que te permite organizar tus tareas en bolsas. Cada bolsa esta programada con unos intervalos de repetición y una prioridad. TaskBag te permite organizar tus tareas de manera que puedas ver en todo momento que tareas tienes que hacer y elegir la que mas te convenga en cada momento. TaskBag esta en desarrollo y espero poder lanzarla pronto. TaskBag esta desarrollada en Flutter y Firebase y es un proyecto personal que estoy desarrollando en mi tiempo libre.',
    status: ProjectsProjectStatus.soon,
    estimatedTimeExpended: '3mo',
    technologies: [
      _technologies[0],
      _technologies[1],
      _technologies[2],
      _technologies[3],
      _technologies[4],
    ],
    screenShotAssetUrls: const [
      'assets/images/app_logo.png',
      'assets/images/app_logo.png',
      'assets/images/app_logo.png',
    ],
  ),
];

abstract class ProjectsLocalDataSource {
  Result<List<ProjectsProject>, Exception> getProjects();
  Result<ProjectsProject, Exception> getProjectById(int id);
}

class LocalDataSourceImpl implements ProjectsLocalDataSource {
  LocalDataSourceImpl();

  @override
  Result<List<ProjectsProject>, Exception> getProjects() {
    try {
      final projects = _projectList;

      return Result.success(data: projects);
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Result<ProjectsProject, Exception> getProjectById(int id) {
    try {
      final project = _projectList.firstWhere(
        (element) => element.id == id,
        orElse: () {
          throw Exception('Project not found');
        },
      );
      return Result.success(data: project);
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }
}
